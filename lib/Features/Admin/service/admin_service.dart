import 'package:workforce/Core/app_core.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> getCurrentUserData() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return null;

      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
    }
    return null;
  }

  Future<int> getTotalEmployees() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Employee')
          .get();
      return snapshot.docs.length;
    } on FirebaseAuthException catch (e) {
      ErrorUtils.handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      ErrorUtils.handleFirestoreError(e);
    }
    return 0;
  }
}
