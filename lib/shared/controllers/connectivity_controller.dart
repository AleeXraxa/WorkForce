import 'package:workforce/Core/app_core.dart';

class ConnectivityController extends GetxController {
  final RxBool isConnected = true.obs;
  bool hasShownDialog = false;

  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnection);
  }

  void _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnection(result);
  }

  void _updateConnection(ConnectivityResult result) {
    bool connected = result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;

    if (!connected && !hasShownDialog) {
      hasShownDialog = true;
      showNoInternetDialog();
    } else if (connected) {
      hasShownDialog = false;
    }

    isConnected.value = connected;
  }

  void showNoInternetDialog() {
    Get.defaultDialog(
      title: "No Internet Connection",
      middleText: "Please check your Wi-Fi or mobile data and try again.",
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      middleTextStyle: TextStyle(fontSize: 14),
      backgroundColor: Colors.white,
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("OK"),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
