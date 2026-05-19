import 'package:flutter/material.dart';
import '../../viewmodels/user_viewmodel.dart';

class SearchBarWidget extends StatelessWidget {
  final UserViewModel viewModel;

  const SearchBarWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: viewModel.searchController,
        onChanged: viewModel.updateSearchQuery,
        decoration: InputDecoration(
          hintText: 'Search by name or email...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: viewModel.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: viewModel.clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}