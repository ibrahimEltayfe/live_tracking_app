enum UserType{
  tracker,
  client,
  unDefined
}

extension UserTypeHandler on UserType{
  String get getString{
    switch(this){
      case UserType.client:
        return "Client";
      case UserType.tracker:
        return "Tracker";
      case UserType.unDefined:
        return "..";
    }
  }
}