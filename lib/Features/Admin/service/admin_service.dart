import 'package:workforce/Core/app_core.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: '${user.username}123',
      );

      final uid = credential.user?.uid ?? '';
      await credential.user?.sendEmailVerification();
      await _firestore.collection('users').doc(uid).set(user.toMap());

      await EmailService.sendWelcomeEmail(
        name: user.firstName,
        email: user.email,
        password: '${user.username}123',
        role: user.role,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      rethrow;
    }
  }
}
