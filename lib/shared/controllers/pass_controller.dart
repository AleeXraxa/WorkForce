import 'package:workforce/Core/app_core.dart';

class PassController extends GetxController {
  RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
