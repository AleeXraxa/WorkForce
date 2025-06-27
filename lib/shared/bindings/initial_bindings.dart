import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/controllers/pass_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
    Get.put(PassController());
  }
}
