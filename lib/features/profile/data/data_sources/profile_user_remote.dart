import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileUserRemote{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async{
    log(GoogleSignIn().currentUser.toString());
    if(GoogleSignIn().currentUser != null){
      await GoogleSignIn().disconnect();
    }
    await _firebaseAuth.signOut();
  }
}