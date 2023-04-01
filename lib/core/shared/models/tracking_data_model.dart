import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_projects/core/shared/enums/session_state_enum.dart';

class TrackingSessionModel extends Equatable{
  String? clientId;
  String? id;
  double? interval;
  String? locationId;
  String? sessionName;
  String? sessionPassword;
  SessionState? state;
  String? trackerId;
  DateTime? createdAt;

  TrackingSessionModel({
      this.clientId, 
      this.id, 
      this.interval, 
      this.locationId,
      this.sessionName,
      this.sessionPassword,
      this.state,
      this.trackerId,
      this.createdAt
  });

  factory TrackingSessionModel.fromJson(Map<String,dynamic> json) {
    DateTime? dateTime;
    Timestamp? timestamp = json['createdAt'];

    if(timestamp != null){
      dateTime = timestamp.toDate();
    }

    return TrackingSessionModel(
      clientId : json['clientId'] ?? '',
      id : json['id'] ?? '',
      interval : (json['interval'] ?? 0.0).toDouble(),
      locationId : json['locationId'] ?? '',
      state : _getSessionStateName(json['state']??''),
      trackerId : json['trackerId'] ?? '',
      createdAt : dateTime ?? DateTime(0),
      sessionName : json['sessionName'] ?? '',
      sessionPassword : json['sessionPassword'] ?? '',
    );

  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(clientId != null) 'clientId':clientId,
      if(id != null) 'id':id,
      if(interval != null) 'interval':interval,
      if(locationId != null) 'locationId':locationId,
      if(state != null) 'state':state!.name,
      if(trackerId != null) 'trackerId':trackerId,
      if(createdAt != null) 'createdAt':Timestamp.fromDate(createdAt!),
      if(sessionName != null) 'sessionName':sessionName,
      if(sessionPassword != null) 'sessionPassword':sessionPassword,
    };
  }

  @override
  List<Object?> get props => [
    clientId,
    id,
    interval,
    locationId,
    state,
    trackerId,
    createdAt,
    sessionName,
    sessionPassword
  ];
}

SessionState _getSessionStateName(String sessionState){
  if(sessionState == SessionState.active.name){
    return SessionState.active;
  }else{
    return SessionState.disabled;
  }

}


