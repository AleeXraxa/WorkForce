import 'package:workforce/Core/app_core.dart';

class PassController extends GetxController {
  var isPass = true.obs;
  var isCPass = true.obs;

  void showPass() {
    isPass.value = !isPass.value;
  }

  void showCpass() {
    isCPass.value = !isCPass.value;
  }
}
