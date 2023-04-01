enum SessionState{
  active,
  disabled
}

extension SessionStateHandler on SessionState{
  String get getString{
    switch(this){
      case SessionState.active:
        return "Active";
      case SessionState.disabled:
        return "disabled";
    }
  }
}