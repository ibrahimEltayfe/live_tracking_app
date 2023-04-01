import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_projects/config/type_def.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:flutter_projects/core/utils/crypto_service.dart';
import '../../../../../../core/error_handling/exceptions.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../../core/utils/network_checker.dart';
import '../data_sources/client_tracking_sessions_remote.dart';

abstract class ClientTrackingSessionsRepository{
  FutureEither<Unit> addSession({required String sessionName,required String sessionPassword, required String clientId});
  Stream<dynamic> getAllSessions(String clientId);
}

class ClientTrackingSessionsRepositoryImpl implements ClientTrackingSessionsRepository{
  final ClientTrackingSessionsRemote _trackingSessionsRemote;
  final NetworkInfo _connectionChecker;
  final CryptoService _cryptoService;
  const ClientTrackingSessionsRepositoryImpl(this._trackingSessionsRemote, this._connectionChecker,this._cryptoService);


  @override
  FutureEither<Unit> addSession({required String sessionName,required String sessionPassword, required String clientId}) async{
    return await _handleFailures(() async{
      final String? password = _cryptoService.aesEncrypt(sessionPassword);

      if(password == null){
        throw CryptoFailure('could not encrypt your password, try again and if the problem still exist please contact us.');
      }

       await _trackingSessionsRemote.addSession(
           sessionName: sessionName,
           sessionPassword: password,
           clientId: clientId
       );

       return unit;
    });
  }

  @override
  Stream<dynamic> getAllSessions(String clientId) async*{
    StreamTransformer streamTransformer = StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<TrackingSessionModel>>
        .fromHandlers(
      handleData: (QuerySnapshot<Map<String,dynamic>> results, EventSink sink) {
        List<TrackingSessionModel> trackingSessionModels = [];

        trackingSessionModels = results.docs.map((e){
          final model = TrackingSessionModel.fromJson(e.data());

          //--decrypt the password--
          final decryptedPassword = _cryptoService.aesDecrypt(model.sessionPassword!) ;
          model.sessionPassword = decryptedPassword;
          return model;
          //--password decrypted--

        }).toList();

        sink.add(trackingSessionModels);
      },
      handleError: (Object e, StackTrace stacktrace, EventSink sink) async{
        log(e.toString());

        if(!(await _connectionChecker.isConnected)) {
          sink.addError(NoInternetFailure());
        }else{
          sink.addError(ExceptionHandler.handle(e).failure);
        }

      },
      handleDone: (EventSink sink) => sink.close(),
    );

    yield* streamTransformer.bind(_trackingSessionsRemote.getAllSessions(clientId));
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