import '../shared/no_context_localization.dart';
import 'geo_action_type.dart';

abstract class Failure{
  final String message;
  final int? code;
  Failure(this.message,{this.code});
}

class GeoFailure extends Failure{
  final GeoActionType geoActionType;
  GeoFailure(super.message, {required this.geoActionType});
}


class DioFailure extends Failure{
  DioFailure(super.message, {super.code});
}


class AuthFailure extends Failure{
  AuthFailure(super.message);
}

class NoInternetFailure extends Failure{
  NoInternetFailure({String? message}):super(message??noContextLocalization().noInternetError);
}

class UnExpectedFailure extends Failure{
  UnExpectedFailure({String? message}):super(message??noContextLocalization().unExpectedError);
}

class NoUIDFailure extends Failure{
  NoUIDFailure({String? message}):super(message??noContextLocalization().noUIDError);
}

class NoDataFailure extends Failure{
  NoDataFailure({String? message}):super(message??noContextLocalization().noDataError);
}

class DataAlreadyExistFailure extends Failure{
  DataAlreadyExistFailure(String message):super(message);
}

class CryptoFailure extends Failure{
  CryptoFailure(String message):super(message);
}


