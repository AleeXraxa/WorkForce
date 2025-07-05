import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static Future<void> sendOtpEmail({
    required String toName,
    required String toEmail,
    required String otpCode,
    required String expiryTime,
  }) async {
    const String _serviceId = 'service_c7v5zfb';
    const String _templateId = 'template_xrscndw';
    const String _userId = 'v-EAZvSTdPS1VHfCL';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': {
          'to_name': toName,
          'to_email': toEmail,
          'passcode': otpCode,
          'time': expiryTime,
        }
      }),
    );

    if (response.statusCode != 200) {
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Failed to send OTP');
    }
  }
}
