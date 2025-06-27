import 'package:workforce/Core/app_core.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
    Get.put(PassController());
    Get.put(AuthController());
  }
}
