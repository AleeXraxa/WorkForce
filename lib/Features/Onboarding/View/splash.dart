import 'package:workforce/Core/app_core.dart';

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
        child: Center(
          child: FadeTransition(
            opacity: fadeIn,
            child: Image.asset(
              'assets/images/Logo.png',
              width: 0.8.sw,
            ),
          ),
        ),
      ),
    );
  }
}
