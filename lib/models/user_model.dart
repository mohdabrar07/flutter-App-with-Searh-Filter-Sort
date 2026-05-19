class UserModel {
  final String id;
  final String name;
  final String email;
  final String company;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
  });
}

final List<UserModel> mockUsers = [
  UserModel(id: '1', name: 'Alice Smith', email: 'alice@google.com', company: 'Google'),
  UserModel(id: '2', name: 'Bob Jones', email: 'bob@apple.com', company: 'Apple'),
  UserModel(id: '3', name: 'Charlie Brown', email: 'charlie@google.com', company: 'Google'),
  UserModel(id: '4', name: 'Diana Prince', email: 'diana@amazon.com', company: 'Amazon'),
  UserModel(id: '5', name: 'Evan Wright', email: 'evan@apple.com', company: 'Apple'),
  UserModel(id: '6', name: 'Fiona Gallagher', email: 'fiona@microsoft.com', company: 'Microsoft'),
];