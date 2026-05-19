import 'package:flutter/material.dart';
import '../viewmodels/user_viewmodel.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/filter_sort_controls.dart';
import 'widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  final UserViewModel viewModel;

  const UserListScreen({super.key, required this.viewModel});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data over the network once when the app page initializes
    widget.viewModel.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Team Directory', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          // A. Handle Network Loading Circle Indicator
          if (widget.viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // B. Handle Network Connection Error Alerts
          if (widget.viewModel.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_off, size: 60, color: Colors.redAccent),
                  const SizedBox(height: 12),
                  Text(widget.viewModel.errorMessage, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: widget.viewModel.fetchUsers,
                    child: const Text('Retry Connection'),
                  )
                ],
              ),
            );
          }

          final users = widget.viewModel.filteredAndSortedUsers;

          return Column(
            children: [
              SearchBarWidget(viewModel: widget.viewModel),
              FilterSortControls(viewModel: widget.viewModel),
              const Divider(height: 1),
              Expanded(
                child: users.isEmpty
                    ? _buildNoResultsScreen(widget.viewModel)
                    : ListView.builder(
                        itemCount: users.length,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          return UserCard(user: users[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNoResultsScreen(UserViewModel viewModel) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_search_outlined, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'No Results Found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                'We couldn\'t find any matches for "${viewModel.searchQuery}" in group "${viewModel.selectedCompany}".',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: viewModel.resetAllFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset All Filters'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}