import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workforce/Core/app_core.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> createUser(
      {required String email, required String pass}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (error) {
      rethrow;
    }
  }
}
