import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/no_context_localization.dart';
import 'dio_errors.dart';
import 'failures.dart';
import 'fb_auth_errors.dart';

class ExceptionHandler implements Exception{
  late final Failure failure;

  ExceptionHandler.handle(dynamic e,{AuthMethod? authMethod}){
    if(e is FirebaseAuthException){
      if(authMethod == null){
        failure = UnExpectedFailure(message:e.message);
      }else{
        failure = AuthFailure(authMethod.getAuthError(e.code));
      }
    }else if(e is FirebaseException){
      failure = UnExpectedFailure(message:e.message);
    }else if(e is DioError){
      failure = handleDioErrors(e);
    }else if(e is Failure){
      failure = e;
    } else{
      failure = UnExpectedFailure();
    }
  }
}


