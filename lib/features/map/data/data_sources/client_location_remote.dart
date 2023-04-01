import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';

class ClientLocationRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getClientLocation(String locationId){
    log(locationId.toString());
    return _firestore.collection(EndPoints.location).doc(locationId).snapshots();
  }
}