import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';

class ClientDataRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getClientData(String userId){
    return _firestore.collection(EndPoints.users).doc(userId).snapshots();
  }

}

