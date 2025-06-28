import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workforce/Core/app_core.dart';

class EmailService {
  static const String serviceId = 'service_0dix3mj';
  static const String templateId = 'template_mbjn9lf';
  static const String publicKey = 'v-EAZvSTdPS1VHfCL';

  static Future<void> sendWelcomeEmail({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      }),
    );

    if (response.statusCode == 200) {
      showAuthDialog(
          title: 'Account Created',
          subtitle: 'Account Successfully Created',
          icon: FontAwesomeIcons.solidCircleCheck,
          onConfirm: () {
            Get.back();
          },
          btnText: 'Close');
    } else {
      Get.snackbar('Email Failed', 'Something Went Wrong');
    }
  }
}
