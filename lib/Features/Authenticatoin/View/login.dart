import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/controllers/pass_controller.dart';
import 'package:workforce/shared/utils/app_validators.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final passController = Get.find<PassController>();
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Image.asset('assets/images/Logo_black.png'),
              Text(
                'Login To Your Account',
                style: AppTextStyles.heading1b,
              ),
              SizedBox(height: 0.03.sh),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    CustomField(
                      labelText: 'Email',
                      controller: controller,
                      validator: AppValidators.isEmail,
                      prefix: FontAwesomeIcons.solidEnvelope,
                    ),
                    SizedBox(height: 0.01.sh),
                    Obx(
                      () => CustomField(
                        labelText: 'Password',
                        controller: controller,
                        validator: AppValidators.isPassword,
                        prefix: FontAwesomeIcons.lock,
                        suffix: passController.isPasswordHidden.value
                            ? FontAwesomeIcons.solidEyeSlash
                            : FontAwesomeIcons.solidEye,
                        isObscure: passController.isPasswordHidden.value,
                        ontap: passController.togglePasswordVisibility,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.snackbar('working', 'Valiedated');
                          }
                        },
                        child: Text('submit')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
