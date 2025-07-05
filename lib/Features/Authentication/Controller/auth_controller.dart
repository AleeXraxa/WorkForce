import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Authentication/View/verification.dart';

class AuthController extends GetxController {
  // Field Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();

  void clearFields() {
    usernameController.clear();
    emailController.clear();
    passController.clear();
    cPassController.clear();
  }

  final AuthService _authService = AuthService();
  final otpController = Get.find<OtpController>();
  final isLoading = false.obs;

  Future<void> registerUser() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final pass = passController.text;
      final username = usernameController.text.trim();

      UserCredential userCredential =
          await _authService.createUser(email: email, pass: pass);

      User? user = userCredential.user;

      if (user != null) {
        final userData = UserModel(
          uid: user.uid,
          username: username,
          email: email,
          isEmailVerified: false,
          role: 'Employee',
          status: 'Pending',
        );
        await _authService.saveUserToFirestore(userData);
      }

      showSuccessDialog(
        'Account Created',
        'Please wait for the email verification',
      );

      await otpController.sendOtp(
          uid: user!.uid, email: email, username: username);
      Get.offAll(() => OtpVerificationScreen(), arguments: {
        'uid': user.uid,
        'username': username,
        'email': email,
      });

      clearFields();
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser() async {
    try {
      isLoading.value = true;

      var email = emailController.text.trim();
      var pass = passController.text.trim();

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      final uid = credential.user!.uid;

      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('User data not found.');
      }

      final data = doc.data()!;
      final isVerified = data['isEmailVerified'] ?? false;
      final status = data['status'] ?? 'Pending';
      final role = data['role'] ?? 'User';

      if (!isVerified) {
        OtpController otpController;
        if (Get.isRegistered<OtpController>()) {
          otpController = Get.find<OtpController>();
        } else {
          otpController = Get.put(OtpController());
        }

        await otpController.sendOtp(
          uid: uid,
          email: email,
          username: data['username'] ?? 'User',
        );

        Get.to(() => const OtpVerificationScreen(), arguments: {
          'uid': uid,
          'username': data['username'],
          'email': email,
        });

        return;
      }

      // 4. Check Account Status
      if (status == 'Pending') {
        Get.dialog(
          AlertDialog(
            title: const Text('Account Under Review'),
            content: const Text('Your account is pending approval.'),
          ),
        );
        return;
      }

      if (status == 'Rejected') {
        Get.dialog(
          AlertDialog(
            title: const Text('Account Rejected'),
            content: const Text('Your account has been rejected.'),
          ),
        );
        return;
      }

      // 5. Navigate Based on Role
      if (role == 'Admin') {
        // Get.offAll(() => AdminDashboard());
      } else if (role == 'HR') {
        // Get.offAll(() => HRDashboard());
      } else if (role == 'Client') {
        // Get.offAll(() => ClientDashboard());
      } else {
        // Get.offAll(() => GeneralDashboard());
      }
      clearFields();
    } catch (e) {
      FirebaseErrorHandler.handle(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    cPassController.dispose();
    super.onClose();
  }
}
