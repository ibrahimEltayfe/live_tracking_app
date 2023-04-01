import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../../core/error_handling/exceptions.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/utils/network_checker.dart';
import '../../../../config/type_def.dart';
import '../data_sources/reset_password_remote.dart';

abstract class ResetPasswordRepository{
  FutureEither<void> resetPassword(String email);
}

class ResetPasswordRepositoryImpl implements ResetPasswordRepository{
  final ResetPasswordRemote _resetPasswordRemote;
  final NetworkInfo _connectionChecker;
  const ResetPasswordRepositoryImpl(this._resetPasswordRemote, this._connectionChecker);

  @override
  FutureEither<void> resetPassword(String email) async{
    return await _handleFailures(() => _resetPasswordRemote.resetPassword(email));
  }

  Future<Either<Failure, type>> _handleFailures<type>(Future<type> Function() task) async{
    if(await _connectionChecker.isConnected) {
      try{
        final type results = await task();
        return Right(results);
      }catch(e){
        log(e.toString());
        return Left(ExceptionHandler.handle(e).failure);
      }
    }else{
      return Left(NoInternetFailure());
    }
  }

}