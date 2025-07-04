import 'package:workforce/Core/app_core.dart';

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

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    cPassController.dispose();
    super.onClose();
  }
}
