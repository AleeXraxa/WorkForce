class UserModel {
  final String uid;
  final String username;
  final String email;
  final bool isEmailVerified;
  final String role;
  final String status;
  final String? fullName;
  final String? gender;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    required this.role,
    required this.status,
    this.fullName,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'role': role,
      'status': status,
      if (fullName != null) 'fullName': fullName,
      if (gender != null) 'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      isEmailVerified: map['isEmailVerified'] ?? false,
      role: map['role'] ?? 'user',
      status: map['status'] ?? 'active',
      fullName: map['fullName'],
      gender: map['gender'],
    );
  }
}
