enum UserState{
  connected,
  disconnected,
  none
}

extension ClientStateHandler on UserState{
  String get getStateName{
    switch(this){
      case UserState.connected : return "connected";
      case UserState.disconnected : return "disconnected";
      case UserState.none : return "";
    }
  }

}