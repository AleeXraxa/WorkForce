import 'dart:async';

import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Authenticatoin/View/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.screenBG,
      body: Column(
        children: [
          Image.asset('assets/images/Logo.png'),
          Text(
            'TryUnity WorkForce',
            style: AppTextStyles.heading1,
          ),
          SizedBox(height: 0.01.sh),
          Text(
            'Your WorkForce, Simplified',
            style: AppTextStyles.smallBodyText,
          ),
          SizedBox(height: 0.3.sh),
          Text(
            'Powered by: TryUnity Solutions',
            style: AppTextStyles.smallBodyText,
          ),
        ],
      ),
    );
  }
}
