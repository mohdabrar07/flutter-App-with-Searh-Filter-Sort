import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedCompany = 'All';
  bool _isAscending = true;
  final TextEditingController searchController = TextEditingController();

  // Getters to expose private state safely to views
  String get searchQuery => _searchQuery;
  String get selectedCompany => _selectedCompany;
  bool get isAscending => _isAscending;

  // Derived state: The processed data output pipeline
  List<UserModel> get filteredAndSortedUsers {
    List<UserModel> filteredList = List.from(mockUsers);

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      filteredList = filteredList.where((user) {
        return user.name.toLowerCase().contains(query) ||
               user.email.toLowerCase().contains(query);
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

  // State Mutators
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}