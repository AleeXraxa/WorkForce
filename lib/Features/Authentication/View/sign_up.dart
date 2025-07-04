import 'package:workforce/Core/app_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor, // Indigo
              Color(0xff171b41), // Charcoal
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
                  'Create Your\nAccount',
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
                      children: [
                        CustomTextField(
                          labelText: 'Username',
                          hintText: 'Alee',
                        ),
                        SizedBox(height: 0.02.sh),
                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'alee@gmail.com',
                        ),
                        SizedBox(height: 0.02.sh),
                        CustomTextField(
                          labelText: 'Password',
                          hintText: '******',
                          suffix: FontAwesomeIcons.solidEyeSlash,
                        ),
                        SizedBox(height: 0.02.sh),
                        CustomTextField(
                          labelText: 'Confirm Password',
                          hintText: '******',
                          suffix: FontAwesomeIcons.solidEyeSlash,
                        ),
                        SizedBox(height: 0.02.sh),
                        PrimaryBtn(
                          text: 'Create Account',
                          bgColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          onTap: () {},
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
