import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/Widgets/dialogs/success_dialog.dart';

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
  final isLoading = false.obs;

  Future<void> registerUser() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final pass = passController.text;

      UserCredential userCredential =
          await _authService.createUser(email: email, pass: pass);

      User? user = userCredential.user;

      if (user != null) {
        final userData = UserModel(
            uid: user.uid,
            username: usernameController.text.trim(),
            email: email,
            isEmailVerified: false,
            role: 'Employee',
            status: 'Pending');
        await _authService.saveUserToFirestore(userData);
      }

      showSuccessDialog(
          'Account Created', 'Your account has been created successfully');
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
