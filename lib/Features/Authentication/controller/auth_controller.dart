import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/utils/error.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final isLoading = false.obs;

  final AuthService _authService = AuthService();

  void clearfields() {
    emailController.clear();
    passController.clear();
  }

  Future<void> loginUser() async {
    try {
      isLoading.value = true;
      final email = emailController.text.trim();
      final pass = passController.text;

      final userCredential = await _authService.loginUser(email, pass);
      final user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          Get.offAll(() => AddUser());
          clearfields();
        } else {
          showAuthDialog(
            title: 'Verification Required',
            subtitle: 'Please verify your email',
            icon: FontAwesomeIcons.circleExclamation,
            onConfirm: () async {
              Get.back();
              await emailVerification();
            },
            btnText: 'Send Email',
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> emailVerification() async {
    try {
      isLoading.value = true;
      await _authService.sendEmailVerification();
      final user = _authService.getCurrentUser();

      if (user != null && user.emailVerified) {
        Get.snackbar('Verified', 'Email is already verified');
      } else {
        Get.snackbar('Email Sent', 'Please check your email');
      }
      clearfields();
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }
}
