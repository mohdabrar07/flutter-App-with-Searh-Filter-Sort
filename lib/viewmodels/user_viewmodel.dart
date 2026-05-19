import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  // Original master dataset fetched from network API layer
  List<UserModel> _masterUsers = [];
  
  String _searchQuery = '';
  String _selectedCompany = 'All';
  bool _isAscending = true;
  bool _isLoading = false;
  String _errorMessage = '';

  final TextEditingController searchController = TextEditingController();

  // Getters
  String get searchQuery => _searchQuery;
  String get selectedCompany => _selectedCompany;
  bool get isAscending => _isAscending;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<UserModel> get masterUsers => _masterUsers;

  // The core operational dynamic data pipeline filtering master list
  List<UserModel> get filteredAndSortedUsers {
    List<UserModel> filteredList = List.from(_masterUsers);

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      filteredList = filteredList.where((user) {
        return user.name.toLowerCase().contains(query) ||
               user.email.toLowerCase().contains(query) ||
               user.company.toLowerCase().contains(query); // <-- ADD THIS LINE
      }).toList();
    }

    if (_selectedCompany != 'All') {
      filteredList = filteredList.where((user) {
        return user.company == _selectedCompany;
      }).toList();
    }

    filteredList.sort((a, b) {
      if (_isAscending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });

    return filteredList;
  }

  // API Async Network Operation Method
  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> decodedJson = json.decode(response.body);
        _masterUsers = decodedJson.map((data) => UserModel.fromJson(data)).toList();
      } else {
        _errorMessage = 'Failed to fetch directory data from server.';
      }
    } catch (e) {
      _errorMessage = 'No internet connection detected.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Controls Layout State Mutators
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSelectedCompany(String company) {
    _selectedCompany = company;
    notifyListeners();
  }

  void toggleSortOrder() {
    _isAscending = !_isAscending;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _searchQuery = '';
    notifyListeners();
  }

  void resetAllFilters() {
    searchController.clear();
    _searchQuery = '';
    _selectedCompany = 'All';
    _isAscending = true;
    notifyListeners();
  }
}