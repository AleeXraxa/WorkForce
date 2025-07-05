import 'dart:async';
import 'package:workforce/Core/app_core.dart';

class OtpController extends GetxController {
  final isVerifying = false.obs;
  final isLoading = false.obs;
  final resendCooldown = 0.obs;
  final otpService = OtpService();

  late TextEditingController otpController;
  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
  }

  Future<void> sendOtp({
    required String uid,
    required String email,
    required String username,
  }) async {
    try {
      await otpService.generateAndSendOtp(
        uid: uid,
        email: email,
        username: username,
      );
      showSuccessDialog('OTP Sent', 'Please check your email');
      startResendCooldown();
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    }
  }

  Future<void> verifyOtp(String uid) async {
    try {
      isLoading.value = true;
      isVerifying.value = true;

      final enteredOtp = otpController.text.trim();
      final success =
          await otpService.verifyOtp(uid: uid, enteredOtp: enteredOtp);

      if (success) {
        showSuccessDialog('Successfully Verified', 'Redirecting to Login');
        await Future.delayed(const Duration(milliseconds: 500));
        otpController.clear();

        Get.offAll(() => Login());
      } else {
        Get.snackbar('Verification Failed', 'Invalid or expired OTP');
      }
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    } finally {
      isLoading.value = false;
      isVerifying.value = false;
    }
  }

  void startResendCooldown() {
    resendCooldown.value = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCooldown.value > 0) {
        resendCooldown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }
}
