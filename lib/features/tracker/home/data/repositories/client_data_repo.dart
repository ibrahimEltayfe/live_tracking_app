import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import '../../../../../../core/error_handling/exceptions.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../../core/utils/network_checker.dart';
import '../data_sources/client_data_remote.dart';

abstract class ClientDataRepository{
  Stream getClientData(String userId);
}

class ClientDataRepositoryImpl implements ClientDataRepository{
  final ClientDataRemote _clientDataRemote;
  final NetworkInfo _connectionChecker;
  const ClientDataRepositoryImpl(this._clientDataRemote, this._connectionChecker);

  @override
  Stream getClientData(String userId) async*{
    StreamTransformer streamTransformer = StreamTransformer<DocumentSnapshot<Map<String,dynamic>>, UserModel?>
        .fromHandlers(
      handleData: (DocumentSnapshot<Map<String,dynamic>> event, EventSink sink) {
        log(event.data().toString());

        if(event.data() == null){
          sink.add(null);
          return;
        }

        sink.add(UserModel.fromJson(event.data()!));
      },
      handleError: (Object e, StackTrace stacktrace, EventSink sink) async{

        if(!(await _connectionChecker.isConnected)) {
          sink.addError(NoInternetFailure());
          return;
        }

        sink.addError(ExceptionHandler.handle(e).failure);

      },
      handleDone: (EventSink sink) => sink.close(),
    );

    yield* streamTransformer.bind(_clientDataRemote.getClientData(userId));
  }
 }

