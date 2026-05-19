import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../viewmodels/user_viewmodel.dart';

class FilterSortControls extends StatelessWidget {
  final UserViewModel viewModel;

  const FilterSortControls({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final List<String> companies = ['All'] + 
        mockUsers.map((user) => user.company).toSet().toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, color: Colors.grey),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: viewModel.selectedCompany,
                underline: const SizedBox(), 
                items: companies.map((String company) {
                  return DropdownMenuItem<String>(
                    value: company,
                    child: Text(company),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.updateSelectedCompany(newValue);
                  }
                },
              ),
            ],
          ),
          TextButton.icon(
            onPressed: viewModel.toggleSortOrder,
            icon: Icon(
              viewModel.isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 18,
            ),
            label: Text(viewModel.isAscending ? 'Sort A-Z' : 'Sort Z-A'),
          ),
        ],
      ),
    );
  }
}