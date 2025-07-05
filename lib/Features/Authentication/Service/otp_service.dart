import 'package:workforce/Core/app_core.dart';

class OtpService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> generateAndSendOtp({
    required String uid,
    required String email,
    required String username,
  }) async {
    final otp = OtpUtils.generateOtp();
    final expiry = DateTime.now().add(const Duration(minutes: 15));

    final otpData = OtpModel(otp: otp, expiry: expiry);

    await _firestore.collection('otps').doc(uid).set(otpData.toMap());

    await EmailService.sendOtpEmail(
      toName: username,
      toEmail: email,
      otpCode: otp,
      expiryTime: OtpUtils.formatDate(expiry),
    );

    return otp;
  }

  Future<bool> verifyOtp({
    required String uid,
    required String enteredOtp,
  }) async {
    final doc = await _firestore.collection('otps').doc(uid).get();

    if (!doc.exists) {
      debugPrint('❌ OTP not found for UID: $uid');
      return false;
    }

    final otpData = OtpModel.fromMap(doc.data()!);

    if (enteredOtp == otpData.otp) {
      if (DateTime.now().isBefore(otpData.expiry)) {
        await _firestore.collection('users').doc(uid).update({
          'isEmailVerified': true,
        });

        await _firestore.collection('otps').doc(uid).delete();

        debugPrint('✅ OTP verified for UID: $uid');
        return true;
      } else {
        debugPrint('❌ OTP expired for UID: $uid');
      }
    } else {
      debugPrint('❌ Invalid OTP entered for UID: $uid');
    }

    return false;
  }
}
