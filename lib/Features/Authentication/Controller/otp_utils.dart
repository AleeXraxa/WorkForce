import 'dart:math';
import 'package:intl/intl.dart';

class OtpUtils {
  static String generateOtp({int length = 6}) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  static String formattedExpiryTime({int minutes = 15}) {
    final expiry = DateTime.now().add(Duration(minutes: minutes));
    return DateFormat('hh:mm a').format(expiry);
  }

  static String formatDate(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
}
