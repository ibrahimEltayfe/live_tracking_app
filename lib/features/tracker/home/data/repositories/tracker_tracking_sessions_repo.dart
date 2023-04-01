import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_projects/config/type_def.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import '../../../../../../core/error_handling/exceptions.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../../core/utils/network_checker.dart';
import '../../../../../core/shared/models/client_location_model.dart';
import '../../../../../core/utils/crypto_service.dart';
import '../data_sources/tracker_tracking_sessions_remote.dart';

abstract class TrackerTrackingSessionsRepository{
  FutureEither<Unit> addSession(TrackingSessionModel trackingSessionModel,ClientLocationModel clientLocationModel);
  FutureEither<List<TrackingSessionModel>> getAllSessions(String trackerId);
  FutureEither<Unit> deleteSession({required String sessionId,required  String locationId});
  FutureEither<Unit> changeSessionState(String sessionId,String state);
}

class TrackerTrackingSessionsRepositoryImpl implements TrackerTrackingSessionsRepository{
  final TrackerTrackingSessionsRemote _trackingSessionsRemote;
  final NetworkInfo _connectionChecker;
  final CryptoService _cryptoService;

  const TrackerTrackingSessionsRepositoryImpl(this._trackingSessionsRemote, this._connectionChecker,this._cryptoService);


  @override
  FutureEither<Unit> addSession(TrackingSessionModel trackingSessionModel,ClientLocationModel locationModel) async{
    return await _handleFailures(() async{
      //--encrypt password--
      final String? encryptedText = _cryptoService.aesEncrypt(trackingSessionModel.sessionPassword!);
      if(encryptedText == null){
        throw CryptoFailure('could not encrypt your password, try again and if the problem still exist please contact us.');
      }
      trackingSessionModel.sessionPassword = encryptedText;
      //--password encrypted--

      await _trackingSessionsRemote.addSession(trackingSessionModel,locationModel);

      return unit;
    });
  }

  @override
  FutureEither<List<TrackingSessionModel>> getAllSessions(String trackerId) async{
    return await _handleFailures<List<TrackingSessionModel>>(() async{
      final results = await _trackingSessionsRemote.getAllSessions(trackerId);

      List<TrackingSessionModel> trackingSessionModels = [];

      trackingSessionModels = results.docs.map((e){
        final model = TrackingSessionModel.fromJson(e.data());

        //--decrypt the password--
        final decryptedPassword = _cryptoService.aesDecrypt(model.sessionPassword!) ;
        model.sessionPassword = decryptedPassword;
        return model;
        //--password decrypted--

      }).toList();

      return trackingSessionModels;
    });
  }

  @override
  FutureEither<Unit> deleteSession({required String sessionId,required  String locationId}) async{
    return await _handleFailures(() async{
      await _trackingSessionsRemote.deleteSession(sessionId,locationId);
      return unit;
    });
  }

  @override
  FutureEither<Unit> changeSessionState(String sessionId,String state) async{
    return await _handleFailures(() async{
      await _trackingSessionsRemote.changeSessionState(sessionId,state);
      return unit;
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