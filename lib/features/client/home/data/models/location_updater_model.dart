import 'dart:async';

class LocationUpdaterModel{
  final String locationId;
  double? intervals;
  final Timer timer;

  LocationUpdaterModel({
    required this.locationId,
    this.intervals,
    required this.timer
  });

}
