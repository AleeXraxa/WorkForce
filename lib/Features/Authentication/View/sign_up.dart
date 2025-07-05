import 'package:workforce/Core/app_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
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
                      'Create Your\nAccount',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.headingW.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: authController.usernameController,
                              labelText: 'Username',
                              hintText: 'Alee',
                              validator: Validators.validateUsername,
                            ),
                            SizedBox(height: 0.02.sh),
                            CustomTextField(
                              controller: authController.emailController,
                              labelText: 'Email',
                              hintText: 'example@email.com',
                              validator: Validators.validateEmail,
                            ),
                            SizedBox(height: 0.02.sh),
                            Obx(() => CustomTextField(
                                  controller: authController.passController,
                                  labelText: 'Password',
                                  hintText: '******',
                                  isPass: passController.isPass.value,
                                  suffix: passController.isPass.value
                                      ? FontAwesomeIcons.solidEyeSlash
                                      : FontAwesomeIcons.solidEye,
                                  onSuffixTap: passController.showPass,
                                  validator: Validators.validatePassword,
                                )),
                            SizedBox(height: 0.02.sh),
                            Obx(() => CustomTextField(
                                  controller: authController.cPassController,
                                  labelText: 'Confirm Password',
                                  hintText: '******',
                                  isPass: passController.isCPass.value,
                                  suffix: passController.isCPass.value
                                      ? FontAwesomeIcons.solidEyeSlash
                                      : FontAwesomeIcons.solidEye,
                                  onSuffixTap: passController.showCpass,
                                  validator: (val) =>
                                      Validators.validateConfirmPassword(val,
                                          authController.passController.text),
                                )),
                            SizedBox(height: 0.02.sh),
                            Obx(
                              () => authController.isLoading.value
                                  ? Lottie.asset(
                                      'assets/animations/newloader.json',
                                      height: 100.h,
                                      width: 100.w,
                                      fit: BoxFit.contain,
                                    )
                                  : PrimaryBtn(
                                      text: 'Create Account',
                                      bgColor: AppColors.primaryColor,
                                      textColor: Colors.white,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          authController.registerUser();
                                        }
                                      },
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: AppTextStyles.subtext,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.off(() => Login());
                                  },
                                  child: Text(
                                    'Login',
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
