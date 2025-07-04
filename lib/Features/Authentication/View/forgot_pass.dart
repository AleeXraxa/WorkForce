import 'package:workforce/Core/app_core.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
                  onPressed: () => Get.back(),
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 0.01.sh),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 35),
                child: Text(
                  'Forgot\nPassword?',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.headingW.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.76.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'We’ll send you a reset link to your email',
                              style: AppTextStyles.subtext.copyWith(
                                fontSize: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 0.04.sh),
                            CustomTextField(
                              controller: authController.emailController,
                              labelText: 'Email',
                              hintText: 'example@email.com',
                              validator: Validators.validateEmail,
                            ),
                            SizedBox(height: 0.03.sh),
                            Center(
                              child: PrimaryBtn(
                                text: 'Send Reset Link',
                                bgColor: AppColors.primaryColor,
                                textColor: Colors.white,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.snackbar(
                                      'Success',
                                      'Reset link sent to your email',
                                    );
                                  }
                                },
                              ),
                            ),
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
