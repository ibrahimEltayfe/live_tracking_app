import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import '../../../../core/error_handling/exceptions.dart';
import '../../../../core/error_handling/failures.dart';
import '../../../../core/error_handling/fb_auth_errors.dart';
import '../../../../core/utils/network_checker.dart';
import '../data_sources/auth_remote.dart';

abstract class AuthRepository{
  Future<Either<Failure, Unit>> loginWithEmail({required String email, required String password});
  Future<Either<Failure, Unit>> register({required String email, required String password,required UserType userType});
  Future<Either<Failure,bool>> loginWithGoogle();
  Future<Either<Failure,Unit>> registerWithGoogle(UserType userType);

}

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemote authRemote;
  final NetworkInfo _connectionChecker;
  AuthRepositoryImpl(this.authRemote, this._connectionChecker);

  @override
  Future<Either<Failure, Unit>> loginWithEmail({required String email, required String password}) async{
    return await _handleFailures(
        AuthMethod.login,
        ()=> authRemote.login(email: email, password: password,)
    );
  }

  @override
  Future<Either<Failure, Unit>> register({required String email, required String password,required UserType userType}) async{
    return await _handleFailures<Unit>(
      AuthMethod.register,
      ()=> authRemote.register(email: email, password: password,userType: userType)
    );
  }

  @override
  Future<Either<Failure,bool>> loginWithGoogle() async{
    return await _handleFailures<bool>(
        AuthMethod.credential,
        ()=> authRemote.loginWithGoogle()
    );
  }

  @override
  Future<Either<Failure,Unit>> registerWithGoogle(UserType userType) async{
    return await _handleFailures<Unit>(
        AuthMethod.credential,
        ()=> authRemote.registerWithGoogle(userType)
    );
  }


  Future<Either<Failure, type>> _handleFailures<type>(AuthMethod authMethod, Future<type> Function() task) async{
      if(await _connectionChecker.isConnected) {
        try{
          final type results = await task();
          return Right(results);
        }catch(e){
          log(e.toString());
          return Left(ExceptionHandler.handle(e,authMethod: authMethod).failure);
        }
      }else{
        return Left(NoInternetFailure());
      }
  }

}