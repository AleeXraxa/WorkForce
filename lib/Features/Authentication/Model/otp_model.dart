import 'package:cloud_firestore/cloud_firestore.dart';

class OtpModel {
  final String otp;
  final DateTime expiry;

  OtpModel({required this.otp, required this.expiry});

  factory OtpModel.fromMap(Map<String, dynamic> map) {
    return OtpModel(
      otp: map['otp'],
      expiry: (map['expiry'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'otp': otp,
        'expiry': expiry,
      };
}
