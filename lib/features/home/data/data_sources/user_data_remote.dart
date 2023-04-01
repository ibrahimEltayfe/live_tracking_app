import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_projects/core/constants/end_points.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';

class UserDataRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async{
    final user = FirebaseAuth.instance.currentUser;

    if(user == null){
      throw NoDataFailure();
    }
     return _firestore.collection(EndPoints.users).doc(user.uid).get();
  }
}