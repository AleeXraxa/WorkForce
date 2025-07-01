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

  Future<UserModel?> getCurrentUserData() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) return null;

    final doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    } else {
      return null;
    }
  }

  Future<int> getTotalEmployees() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'Employee')
        .get();
    return snapshot.docs.length;
  }
}
