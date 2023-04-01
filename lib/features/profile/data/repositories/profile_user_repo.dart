import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_projects/config/type_def.dart';
import '../../../../../core/error_handling/exceptions.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/utils/network_checker.dart';
import '../data_sources/profile_user_remote.dart';

abstract class ProfileUserRepository{
  FutureEither<Unit> signOut();
}

class ProfileUserRepositoryImpl implements ProfileUserRepository{
  final ProfileUserRemote _profileUserRemote;
  final NetworkInfo _connectionChecker;
  const ProfileUserRepositoryImpl(this._profileUserRemote, this._connectionChecker);

  @override
  FutureEither<Unit> signOut() async{
    return await _handleFailures(() => _profileUserRemote.signOut());
  }


  Future<Either<Failure, Unit>> _handleFailures(Future Function() task) async{
    if(await _connectionChecker.isConnected) {
      try{
        await task();
        return const Right(unit);
      }catch(e){
        log(e.toString());
        return Left(ExceptionHandler.handle(e).failure);
      }
    }else{
      return Left(NoInternetFailure());
    }
  }

}