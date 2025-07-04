import 'package:workforce/Core/app_core.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut(() => PassController(), fenix: true);
  }
}
