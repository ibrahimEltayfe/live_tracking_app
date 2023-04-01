import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_projects/core/shared/enums/user_state.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ntp/ntp.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/shared/enums/user_type.dart';

class AuthRemote {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Unit> login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    return unit;
  }

  Future<Unit> register({required String email, required String password,required UserType userType}) async {
    //register
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    await _initializeUserData(
       userCredential,
       userType
    );

    return unit;
  }

  Future<UserCredential> _googleAuth() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //social logins
  Future<bool> loginWithGoogle() async {
    final userCredential = await _googleAuth();

    final bool isUserExists = await _isUserDataExists(userCredential.user!.uid);
    return isUserExists;

  }

  Future<Unit> registerWithGoogle(UserType userType) async {
    final userCredential = await _googleAuth();

    final bool isUserExists = await _isUserDataExists(userCredential.user!.uid);
    if(!isUserExists){
      await _initializeUserData(
          userCredential,
          userType
      );
    }

    return unit;

  }

  Future<bool> _isUserDataExists(String uid) async {
    final results = await _fs.collection(EndPoints.users).doc(uid).get();
    return results.data() != null;
  }

  Future<void> _initializeUserData(UserCredential userCredential,UserType type) async{
    final user = userCredential.user!;
    final DateTime? creationDate = user.metadata.creationTime;

      //fill tracker data
      final UserModel userModel = UserModel();
      userModel.image = user.photoURL ?? '';
      userModel.name = user.displayName ?? '';
      userModel.id = user.uid;
      userModel.createdAt = creationDate?? await NTP.now();
      userModel.email = user.email;
      userModel.type = type;
      userModel.state = UserState.connected;

      //save client data
      await _fs.collection(EndPoints.users).doc(user.uid).set(userModel.toJson());

  }

}