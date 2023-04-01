import 'package:dio/dio.dart';
import '../shared/no_context_localization.dart';
import 'failures.dart';

Failure handleDioErrors(DioError error){
  switch(error.type){
    case DioErrorType.badResponse:
        if(error.response!.statusCode != null){
          switch (error.response!.statusCode) {
            case ResponseCode.BAD_REQUEST:
              return DioErrorTypes.BAD_REQUEST.getFailure();

            case ResponseCode.UN_AUTHORIZED:
              return DioErrorTypes.UN_AUTHORIZED.getFailure();

            case ResponseCode.NOT_FOUND:
              return DioErrorTypes.NOT_FOUND.getFailure();

            case ResponseCode.INTERNAL_SERVER_ERROR:
              return DioErrorTypes.INTERNAL_SERVER_ERROR.getFailure();

            default:
              return DioErrorTypes.DEFAULT.getFailure();
          }
        }

      return DioErrorTypes.DEFAULT.getFailure();

    default:
      return DioErrorTypes.DEFAULT.getFailure();

  }
}

enum DioErrorTypes{
  BAD_REQUEST,
  UN_AUTHORIZED,
  FORBIDDEN,
  REQUEST_TIMEOUT,
  INTERNAL_SERVER_ERROR,
  NOT_FOUND,
  DEFAULT
}

class ResponseCode{
  static const int BAD_REQUEST = 400; // API rejected request
  static const int UN_AUTHORIZED = 401; // un authorized user
  static const int FORBIDDEN = 403; // API rejected request
  static const int NOT_FOUND = 404; // crash in server side
  static const int REQUEST_TIMEOUT= 408;
  static const int INTERNAL_SERVER_ERROR =500; // crash in server side
  static const int DEFAULT = -7;
}

extension ErrorHandling on DioErrorTypes{
  Failure getFailure(){
    final localization = noContextLocalization();
    switch(this){
      case DioErrorTypes.BAD_REQUEST:
        return DioFailure(localization.dioBadRequest,code: ResponseCode.BAD_REQUEST);

      case DioErrorTypes.UN_AUTHORIZED:
        return DioFailure(localization.dioUnAuthorized, code:ResponseCode.UN_AUTHORIZED);

      case DioErrorTypes.FORBIDDEN:
        return DioFailure(localization.dioForbidden,code: ResponseCode.FORBIDDEN);

      case DioErrorTypes.REQUEST_TIMEOUT:
        return DioFailure(localization.dioRequestTimeout,code: ResponseCode.REQUEST_TIMEOUT);

      case DioErrorTypes.INTERNAL_SERVER_ERROR:
        return DioFailure(localization.dioInternalServerError,code: ResponseCode.INTERNAL_SERVER_ERROR);

      case DioErrorTypes.NOT_FOUND:
        return DioFailure(localization.dioNotFound,code: ResponseCode.NOT_FOUND);

      case DioErrorTypes.DEFAULT:
        return DioFailure(localization.unExpectedError,code: ResponseCode.DEFAULT);
  }
  }
}

