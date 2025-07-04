import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Authentication/View/forgot_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final passController = Get.find<PassController>();
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  late Animation<Offset> _headerSlide;
  late Animation<double> _headerFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _headerFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 0.01.sh),

              // ✅ Animated Header
              FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 35),
                    child: Text(
                      'Login To Your\nAccount',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.headingW.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // ✅ Animated Form
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
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 0.02.sh),
                            CustomTextField(
                              controller: authController.emailController,
                              labelText: 'Email',
                              hintText: 'example@email.com',
                              validator: Validators.validateEmail,
                            ),
                            SizedBox(height: 0.02.sh),
                            Obx(
                              () => CustomTextField(
                                controller: authController.passController,
                                labelText: 'Password',
                                hintText: '******',
                                isPass: passController.isPass.value,
                                suffix: passController.isPass.value
                                    ? FontAwesomeIcons.solidEyeSlash
                                    : FontAwesomeIcons.solidEye,
                                onSuffixTap: passController.showPass,
                                validator: Validators.validatePassword,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgotPassword());
                              },
                              child: Text(
                                'Forgot Password',
                                style: AppTextStyles.subtext.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                            Center(
                              child: PrimaryBtn(
                                text: 'Login',
                                bgColor: AppColors.primaryColor,
                                textColor: Colors.white,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.snackbar('Success', 'Validated');
                                  }
                                },
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
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
