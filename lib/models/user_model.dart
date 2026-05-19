class UserModel {
  final int id; // Changed to int to match the placeholder API
  final String name;
  final String email;
  final String company;
  final String phone;   // Added for details page
  final String website; // Added for details page

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
    required this.phone,
    required this.website,
  });

  // Factory constructor to convert JSON map into UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      // The API nests company inside a 'company' map object, so we look for 'name' inside it
      company: json['company'] != null ? json['company']['name'] ?? '' : '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
    );
  }
}