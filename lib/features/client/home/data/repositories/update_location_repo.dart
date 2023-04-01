import 'dart:developer';
import 'package:flutter_projects/features/client/home/data/data_sources/update_location_remote.dart';
import 'package:dartz/dartz.dart';
import '../../../../../config/type_def.dart';
import '../../../../../core/error_handling/exceptions.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/shared/models/client_location_model.dart';
import '../../../../../core/utils/network_checker.dart';

abstract class UpdateLocationRepository{
  FutureEither<void> updateLocation(ClientLocationModel locationModel);
}

class UpdateLocationRepositoryImpl implements UpdateLocationRepository{
  final UpdateLocationRemote updateLocationRemote;
  final NetworkInfo _connectionChecker;
  const UpdateLocationRepositoryImpl(this.updateLocationRemote, this._connectionChecker);

  @override
  FutureEither<void> updateLocation(ClientLocationModel locationModel) async{
    return await _handleFailures(
      ()=> updateLocationRemote.updateLocation(locationModel: locationModel,));
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