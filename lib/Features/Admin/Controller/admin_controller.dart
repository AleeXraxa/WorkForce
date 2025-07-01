import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/utils/error.dart';

class AdminController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();

  void clearFields() {
    usernameController.clear();
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    dobController.clear();
    selectedGender.value = '';
    selectedRole.value = '';
  }

  RxString selectedRole = ''.obs;
  RxString selectedGender = ''.obs;

  final AdminService _adminService = AdminService();

  void setRole(String role) => selectedRole.value = role;
  void setGender(String gender) => selectedGender.value = gender;

  final isLoading = false.obs;

  Future<void> addNewUser() async {
    try {
      isLoading.value = true;
      final user = UserModel(
        id: '',
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
      clearFields();
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Get all Data of user
  Rxn<UserModel> currentUserData = Rxn<UserModel>();

  Future<void> loadCurrentUser() async {
    final user = await _adminService.getCurrentUserData();
    if (user != null) {
      currentUserData.value = user;
    }
  }

  RxInt totalEmployees = 0.obs;

  Future<void> fetchDashboardStats() async {
    try {
      totalEmployees.value = await _adminService.getTotalEmployees();
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
    } finally {}
  }

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
