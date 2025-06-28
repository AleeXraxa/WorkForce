import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Admin/view/add_user.dart';
import 'package:workforce/Features/Authentication/service/auth_service.dart';
import 'package:workforce/shared/Widgets/custom%20Dialogs/auth_dialog.dart';

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
      handleFirebaseAuthError(e);
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
      handleFirebaseAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Firebase Error Handling
  void handleFirebaseAuthError(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'user-disabled':
        message = 'This user has been disabled.';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password.';
        break;
      case 'email-already-in-use':
        message = 'The email is already in use by another account.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled.';
        break;
      case 'weak-password':
        message = 'The password is too weak.';
        break;
      case 'account-exists-with-different-credential':
        message = 'Account exists with different credentials.';
        break;
      case 'invalid-credential':
        message = 'Invalid credentials provided.';
        break;
      case 'invalid-verification-code':
        message = 'Invalid verification code.';
        break;
      case 'invalid-verification-id':
        message = 'Invalid verification ID.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your connection.';
        break;
      case 'too-many-requests':
        message = 'Too many attempts. Try again later.';
        break;
      case 'timeout':
        message = 'The request timed out.';
        break;
      case 'credential-already-in-use':
        message = 'This credential is already linked with another account.';
        break;
      case 'requires-recent-login':
        message = 'Please log in again to perform this action.';
        break;
      case 'missing-verification-code':
        message = 'Verification code is missing.';
        break;
      case 'missing-verification-id':
        message = 'Verification ID is missing.';
        break;
      case 'internal-error':
        message = 'Internal error occurred. Try again.';
        break;
      default:
        message = 'An undefined error occurred: ${e.code}';
    }

    Get.closeCurrentSnackbar();
    Get.snackbar(
      'Authentication Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundGradient: const LinearGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      colorText: Colors.black,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
    );
  }
}
