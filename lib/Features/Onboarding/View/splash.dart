import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Onboarding/View/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    navigateTo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void navigateTo() async {
    await Future.delayed(_controller.duration! + Duration(seconds: 2));
    Get.offAll(() => MainOnboarding());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: fadeIn,
          child: Image.asset(
            'assets/images/Logo_black.png',
            width: 0.5.sw,
          ),
        ),
      ),
    );
  }
}
