import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_projects/config/type_def.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import '../../../../../core/error_handling/exceptions.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/utils/network_checker.dart';
import '../data_sources/user_data_remote.dart';

abstract class UserDataRepository{
  FutureEither<UserModel?> getUserData();
}

class UserDataRepositoryImpl implements UserDataRepository{
  final UserDataRemote _userDataRemote;
  final NetworkInfo _connectionChecker;
  const UserDataRepositoryImpl(this._userDataRemote, this._connectionChecker);

  @override
  FutureEither<UserModel?> getUserData() async{
    return _handleFailures<UserModel?>(() async{
      final results = await _userDataRemote.getUserData();
      if(results.data() == null){
        throw NoDataFailure();
      }

      return UserModel.fromJson(results.data()!);

    });
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