import 'package:workforce/Core/app_core.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final isVerifying = false.obs;
  final otpService = OtpService();

  Future<void> sendOtp({
    required String uid,
    required String email,
    required String username,
  }) async {
    await otpService.generateAndSendOtp(
      uid: uid,
      email: email,
      username: username,
    );
  }

  final isLoading = false.obs;
  Future<void> verifyOtp(String uid) async {
    try {
      isLoading.value = true;
      isVerifying.value = true;
      final enteredOtp = otpController.text.trim();

      final success = await otpService.verifyOtp(
        uid: uid,
        enteredOtp: enteredOtp,
      );

      if (success) {
        showSuccessDialog('Succefully Verified', 'Redirecting to Login');
        await Future.delayed(const Duration(milliseconds: 300));
        Get.offAll(() => Login());
      } else {
        print('error');
      }
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    } finally {
      isVerifying.value = false;
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
