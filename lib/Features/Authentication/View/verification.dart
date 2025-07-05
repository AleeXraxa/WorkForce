import 'package:workforce/Core/app_core.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerFade;

  final OtpController otpController = Get.put(OtpController());

  late final String uid;
  late final String username;
  late final String email;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>;
    uid = args['uid'];
    username = args['username'];
    email = args['email'];

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
    if (Get.isRegistered<OtpController>()) {
      Get.delete<OtpController>();
    }
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
            colors: [AppColors.primaryColor, Color(0xff171b41)],
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
                    Get.offAll(() => Login());
                  },
                  icon: const FaIcon(FontAwesomeIcons.arrowLeft,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 0.01.sh),
              FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 35),
                    child: Text(
                      'Verify Your Email',
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
                height: 0.81.sh,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Enter the 6-digit code sent to your email address.\n$email',
                            style: AppTextStyles.subtext,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 0.05.sh),
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            controller: otpController.otpController,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10.r),
                              fieldHeight: 50,
                              fieldWidth: 45,
                              inactiveFillColor: Colors.grey.shade200,
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveColor: Colors.grey.shade400,
                              activeColor: AppColors.primaryColor,
                              selectedColor: AppColors.primaryColor,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            onChanged: (_) {},
                          ),
                          SizedBox(height: 0.04.sh),
                          Obx(() {
                            return otpController.isLoading.value
                                ? Lottie.asset(
                                    'assets/animations/newloader.json',
                                    height: 100.h,
                                    width: 100.w,
                                  )
                                : PrimaryBtn(
                                    text: 'Verify OTP',
                                    bgColor: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    onTap: () => otpController.verifyOtp(uid),
                                  );
                          }),
                          SizedBox(height: 20.h),
                          Obx(() => otpController.resendCooldown.value > 0
                              ? Text(
                                  "Resend in ${otpController.resendCooldown.value}",
                                  style: AppTextStyles.subtext,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Didn't receive the code?",
                                        style: AppTextStyles.subtext),
                                    TextButton(
                                      onPressed: () => otpController.sendOtp(
                                        uid: uid,
                                        email: email,
                                        username: username,
                                      ),
                                      child: Text(
                                        'Resend',
                                        style: AppTextStyles.subtext.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                        ],
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
