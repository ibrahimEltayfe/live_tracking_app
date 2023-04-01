import 'package:cloud_firestore/cloud_firestore.dart';

class ClientLocationModel{
  String? id;
  double? lat;
  double? lon;
  DateTime? time;

  ClientLocationModel({
    this.id,
    this.lat,
    this.lon,
    this.time,
  });

  factory ClientLocationModel.fromJson(Map<String,dynamic> json) {
    DateTime timeDate = json['time'] == null ? DateTime(0) : json['time'].toDate();
//todo:(test) try to put lat and lon with null,handle -1.0 value in UI
    return ClientLocationModel(
      time: timeDate,
      lon: (json['lon'] == null) ? null : double.tryParse(json['lon'].toString()),
      lat: (json['lat'] == null) ? null : double.tryParse(json['lat'].toString()) ,
      id: json['id'] ?? '' ,
    );

  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'time':Timestamp.fromDate(time!),
      'id':id,
      'lon':lon,
      'lat':lat,
    };
  }

}
