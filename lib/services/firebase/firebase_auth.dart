import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  late FirebaseAuth _firebaseAuth;
  FirebaseAuthentication() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<User?> getCurrentUser() async {
    final User? user = _firebaseAuth.currentUser!;
    return user;
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = authResult.user;
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
