import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/constants/end_points.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';

class ClientTrackingSessionsRemote{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSession({
    required String sessionName,
    required String sessionPassword,
    required String clientId
  }) async{
    final results = await _firestore.collection(EndPoints.trackingSessions)
        .where('sessionName', isEqualTo: sessionName)
        .where('sessionPassword', isEqualTo: sessionPassword)
        .get();


    if(results.docs.isNotEmpty){
      final String? docClientId = results.docs.first.data()['clientId'];
      log((docClientId != null && docClientId.isNotEmpty).toString());

      if(docClientId == null || docClientId.isEmpty){

          await _firestore.collection(EndPoints.trackingSessions).doc(results.docs.first.id).update({
            'clientId' : clientId
          });

      }else{
        if(results.docs.first.data()['clientId'] == clientId){

          throw UnExpectedFailure(message:'You are already associated with this session.');

        }else {

          throw UnExpectedFailure(message: 'There is already a client associated with this session.');

        }
      }

    }else{
      throw NoDataFailure(message:'there is no session matches your inputs.');
    }

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSessions(String clientId){
    return _firestore.collection(EndPoints.trackingSessions)
     .where('clientId',isEqualTo: clientId)
     .snapshots();
  }
}