import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';

class TrackerDataRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getTrackerData(String trackerId){
    return _firestore.collection(EndPoints.users).where(
      'id', isEqualTo: trackerId
    ).snapshots();

  }
}