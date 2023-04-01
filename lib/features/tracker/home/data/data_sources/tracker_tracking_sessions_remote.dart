import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';
import 'package:ntp/ntp.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/shared/models/client_location_model.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../../core/shared/no_context_localization.dart';

class TrackerTrackingSessionsRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSession(TrackingSessionModel trackingSessionModel,ClientLocationModel clientLocationModel) async{
    final isSessionNameUsed = await _firestore.collection(EndPoints.trackingSessions)
        .where('sessionName', isEqualTo: trackingSessionModel.sessionName).get();

    if(isSessionNameUsed.docs.isNotEmpty){
      throw DataAlreadyExistFailure(noContextLocalization().sessionNameIsUsedError);
    }

    //fill the date
    final DateTime currentDate = await NTP.now();
    trackingSessionModel.createdAt = currentDate;

    //fill ids
    final sessionDoc = _firestore.collection(EndPoints.trackingSessions).doc();
    trackingSessionModel.id = sessionDoc.id;

    final locationDoc = _firestore.collection(EndPoints.location).doc();
    clientLocationModel.id = locationDoc.id;
    trackingSessionModel.locationId = locationDoc.id;

    //add session and location data
    await _firestore.runTransaction((transaction) async{
      transaction.set(sessionDoc, trackingSessionModel.toJson());
      transaction.set(locationDoc, clientLocationModel.toJson());
    });
  }

  Future<void> deleteSession(String sessionId,String locationId) async{
    await _firestore.runTransaction((transaction) async{
      transaction.delete(_firestore.collection(EndPoints.trackingSessions).doc(sessionId));
      transaction.delete(_firestore.collection(EndPoints.location).doc(locationId));
    });
  }

  Future<void> changeSessionState(String sessionId,String state) async{
    await _firestore.collection(EndPoints.trackingSessions).doc(sessionId).update({
      "state" : state
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllSessions(String trackerId) async{
    return await _firestore.collection(EndPoints.trackingSessions)
        .where('trackerId',isEqualTo: trackerId)
        .get();
  }
}