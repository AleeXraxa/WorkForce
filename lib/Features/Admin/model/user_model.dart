class UserModel {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String mobile;
  final String role;
  final String dob;

  UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.mobile,
    required this.role,
    required this.dob,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      role: map['role'] ?? '',
      dob: map['dob'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'email': email,
      'mobile': mobile,
      'role': role,
      'dob': dob,
    };
  }
}
