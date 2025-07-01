import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/bottomNavbar/navbar.dart';
import 'package:workforce/shared/utils/error.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final isLoading = false.obs;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _database = FirebaseFirestore.instance;

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
          final userData =
              await _database.collection('users').doc(user.uid).get();

          if (!userData.exists) {
            showAuthDialog(
              title: 'User not Found',
              subtitle: 'Your account is Blocked',
              icon: FontAwesomeIcons.solidCircleXmark,
              onConfirm: () => Get.back(),
              btnText: 'Close',
            );
            return;
          }

          final role = userData['role'];

          if (role == 'Admin') {
            final adminController = Get.find<AdminController>();
            await adminController.loadCurrentUser(); // 👈 Important
            Get.offAll(() => RoleBasedNavBar(userRole: role));
          } else if (role == 'Employee') {
            Get.snackbar('Welcome', 'Employee');
          } else if (role == 'Client') {
            Get.snackbar('Welcome', 'Client');
          } else {
            Get.snackbar('Invalid Role', 'Invalid');
          }

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
