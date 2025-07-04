import 'package:workforce/Core/app_core.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF575cae), // Dark Indigo Blue
              Color(0xff171b41), // Almost Black (Charcoal)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 1.sw,
                  ),
                  SizedBox(height: 0.05.sh),
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headingW,
                  ),
                  SizedBox(height: 0.01.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Stay connected. Stay productive. All in one app.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subtextW,
                    ),
                  ),
                  SizedBox(height: 0.05.sh),
                  PrimaryBtn(
                    text: 'LOGIN',
                    textColor: Colors.white,
                    bgColor: Color(0xFF3E4AFF),
                  ),
                  SizedBox(height: 0.02.sh),
                  PrimaryBtn(
                    text: 'SIGN UP',
                    bgColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 0.05.sh),
                  SocialBtn(
                    icon: 'assets/icons/google.png',
                    text: 'Continue with Google',
                    onTap: () {},
                  ),
                  SizedBox(height: 0.01.sh),
                  SocialBtn(
                    icon: 'assets/icons/linkedin.png',
                    text: 'Continue with LinkedIn',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
