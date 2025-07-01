import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/utils/error.dart';

class AdminController extends GetxController {
  final AdminService _adminService = AdminService();

  Rxn<UserModel> currentUserData = Rxn<UserModel>();
  RxInt totalEmployees = 0.obs;

  Future<void> loadCurrentUser() async {
    try {
      final user = await _adminService.getCurrentUserData();
      if (user != null) {
        currentUserData.value = user;
      }
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
    }
  }

  Future<void> fetchDashboardStats() async {
    try {
      final total = await _adminService.getTotalEmployees();
      totalEmployees.value = total;
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
      totalEmployees.value = 0;
    }
  }
}
