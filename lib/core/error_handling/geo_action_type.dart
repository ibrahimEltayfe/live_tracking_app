enum GeoActionType{
  openAppSettings,
  openLocationSettings
}

extension GEOSettingsErrorMessages on GeoActionType{
  String get getErrorMessage{
    switch(this){
      case GeoActionType.openAppSettings : return 'Location permissions are denied';
      case GeoActionType.openLocationSettings : return 'Location service is disabled.';
    }
  }

  String get getActionMessage{
    switch(this){
      case GeoActionType.openAppSettings : return 'Open App Settings';
      case GeoActionType.openLocationSettings : return 'Open Location Settings';
    }
  }
}