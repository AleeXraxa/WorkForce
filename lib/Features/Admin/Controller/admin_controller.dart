import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Admin/model/user_model.dart';
import 'package:workforce/Features/Admin/service/admin_service.dart';

class AdminController extends GetxController {
  // Form controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();

  // Dropdown values
  RxString selectedRole = ''.obs;
  RxString selectedGender = ''.obs;

  final AdminService _adminService = AdminService();

  void setRole(String role) => selectedRole.value = role;

  void setGender(String gender) => selectedGender.value = gender;

  Future<void> addNewUser() async {
    final user = UserModel(
      id: '', // Will be updated after Firestore save
      username: usernameController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      gender: selectedGender.value,
      email: emailController.text.trim(),
      mobile: mobileController.text.trim(),
      role: selectedRole.value,
      dob: dobController.text.trim(),
    );

    await _adminService.createUser(user);
    Get.snackbar('Success', 'User added successfully');
  }

  // Optional: Dispose controllers
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
