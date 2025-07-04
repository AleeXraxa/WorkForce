import 'package:workforce/Core/app_core.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final passController = Get.find<PassController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              Color(0xff171b41),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.05.sh),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: IconButton(
                  onPressed: () {
                    Get.offAll(() => Welcome());
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 0.01.sh),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 35),
                child: Text(
                  'Login To Your\nAccount',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.headingW
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.75.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 0.02.sh),
                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'alee@gmail.com',
                        ),
                        SizedBox(height: 0.02.sh),
                        Obx(() => CustomTextField(
                              labelText: 'Password',
                              hintText: '******',
                              isPass: passController.isPass.value,
                              suffix: passController.isPass.value
                                  ? FontAwesomeIcons.solidEyeSlash
                                  : FontAwesomeIcons.solidEye,
                              onSuffixTap: passController.showPass,
                            )),
                        TextButton(
                            onPressed: () {
                              Get.off(() => SignUp());
                            },
                            child: Text(
                              'Forgot Password',
                              style: AppTextStyles.subtext.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        SizedBox(height: 0.02.sh),
                        Center(
                          child: PrimaryBtn(
                            text: 'Login',
                            bgColor: AppColors.primaryColor,
                            textColor: Colors.white,
                            onTap: () {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppTextStyles.subtext,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.off(() => SignUp());
                                },
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyles.subtext.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
