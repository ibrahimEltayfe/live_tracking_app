import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import '../enums/user_state.dart';

class UserModel{
  String? id;
  String? image;
  String? name;
  UserState? state;
  DateTime? createdAt;
  String? email;
  UserType? type;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.state,
    this.createdAt,
    this.email,
    this.type
  });

  factory UserModel.fromJson(Map<String,dynamic> json) {
    final DateTime createdDate;
    if(json['createdAt'] != null){
      createdDate = (json['createdAt'] as Timestamp).toDate();
    }else{
      createdDate = DateTime(0);
    }

    return UserModel(
      id : json['id'] ?? '',
      name : json['name'] ?? '',
      image : json['image'] ?? '',
      state : getState(json['state']),
      createdAt: createdDate,
      email: json['email'] ?? '',
      type: getUserType(json['type'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if(id != null) 'id': id,
      if(name != null) 'name': name,
      if(image != null) 'image': image,
      if(state != null) 'state': state!.getStateName,
      if(createdAt != null) 'createdAt' : Timestamp.fromDate(createdAt!),
      if(email != null) 'email': email,
      if(type != null) 'type' : type!.name
    };
  }
}


UserState getState(String? state){
  if(state == null){
    return UserState.none;
  }

  switch(state){
    case "connected" : return UserState.connected;
    case "disconnected" : return UserState.disconnected;
    default: return UserState.none;
  }
}

UserType getUserType(String? type){
  if(type == null){
    return UserType.unDefined;
  }

  switch(type){
    case "client" : return UserType.client;
    case "tracker" : return UserType.tracker;
    default: return UserType.unDefined;
  }
}