import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRemote{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}