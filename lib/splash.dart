import 'package:workforce/Core/app_core.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final ConnectivityController connectionController =
      Get.find<ConnectivityController>();

  bool hasNavigated = false;
  Timer? splashTimer;

  @override
  void initState() {
    super.initState();

    ever(connectionController.isConnected, (connected) {
      if (connected == true && !hasNavigated) {
        splashTimer = Timer(const Duration(seconds: 5), () {
          hasNavigated = true;
          Get.offAll(() => const Login());
        });
      } else {
        // Internet disconnected → cancel navigation
        splashTimer?.cancel();
        hasNavigated = false;
      }
    });
  }

  @override
  void dispose() {
    splashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.screenBG,
      body: Obx(
        () => connectionController.isConnected.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              )
            : const Center(
                child: Text(
                  "No Internet ❌",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
      ),
    );
  }
}
