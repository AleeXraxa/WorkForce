import 'package:workforce/Core/app_core.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut<OtpController>(() => OtpController());
    Get.put(AuthController(), permanent: true);
    Get.put(PassController(), permanent: true);
  }
}
