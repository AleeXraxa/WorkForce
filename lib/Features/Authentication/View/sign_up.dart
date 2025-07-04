import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Authentication/View/login.dart';

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
              Color(0xFF575cae), // Indigo
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
                          bgColor: AppColors.primaryBtn,
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

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? suffix;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextStyles.labelText),
        SizedBox(height: 0.01.sh),
        TextFormField(
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 11.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: () {},
                    icon: FaIcon(suffix),
                  )
                : null,
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
