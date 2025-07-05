import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Authentication/View/verification.dart';

class AuthController extends GetxController {
  // Field Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();

  void clearFields() {
    usernameController.clear();
    emailController.clear();
    passController.clear();
    cPassController.clear();
  }

  final AuthService _authService = AuthService();
  final otpController = Get.find<OtpController>();
  final isLoading = false.obs;

  Future<void> registerUser() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final pass = passController.text;
      final username = usernameController.text.trim();

      UserCredential userCredential =
          await _authService.createUser(email: email, pass: pass);

      User? user = userCredential.user;

      if (user != null) {
        final userData = UserModel(
          uid: user.uid,
          username: username,
          email: email,
          isEmailVerified: false,
          role: 'Employee',
          status: 'Pending',
        );
        await _authService.saveUserToFirestore(userData);
      }

      showSuccessDialog(
        'Account Created',
        'Please wait for the email verification',
      );

      await otpController.sendOtp(
          uid: user!.uid, email: email, username: username);
      Get.offAll(() => OtpVerificationScreen(), arguments: {
        'uid': user.uid,
        'username': username,
        'email': email,
      });

      clearFields();
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    cPassController.dispose();
    super.onClose();
  }
}
