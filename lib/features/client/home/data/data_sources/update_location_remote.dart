import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';
import '../../../../../core/shared/models/client_location_model.dart';

class UpdateLocationRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLocation({required ClientLocationModel locationModel}) async{
    await _firestore.collection(EndPoints.location).doc(locationModel.id).update(locationModel.toJson());
  }


}