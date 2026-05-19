import 'package:flutter/material.dart';
import 'viewmodels/user_viewmodel.dart';
import 'views/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserViewModel _userViewModel = UserViewModel();

  @override
  void dispose() {
    _userViewModel.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directory App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: UserListScreen(viewModel: _userViewModel),
    );
  }
}