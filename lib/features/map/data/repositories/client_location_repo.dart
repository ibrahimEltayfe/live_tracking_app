import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/error_handling/exceptions.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/utils/network_checker.dart';
import '../../../../core/shared/models/client_location_model.dart';
import '../data_sources/client_location_remote.dart';

abstract class ClientLocationRepository{
  Stream getClientLocation(String locationId);
}

class ClientLocationRepositoryImpl implements ClientLocationRepository{
  final ClientLocationRemote _clientLocationRemote;
  final NetworkInfo _connectionChecker;
  const ClientLocationRepositoryImpl(this._clientLocationRemote, this._connectionChecker);

  @override
  Stream getClientLocation(String locationId){
    return _handleFailures(() => _clientLocationRemote.getClientLocation(locationId));
  }

  Stream<dynamic> _handleFailures<type>(Stream<type> Function() task) async*{
    StreamTransformer streamTransformer = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, ClientLocationModel?>
     .fromHandlers(
      handleData: (DocumentSnapshot<Map<String,dynamic>> event, EventSink sink) {
        log(event.data().toString());

        if(event.data() == null){
          sink.add(null);
          return;
        }

        sink.add(ClientLocationModel.fromJson(event.data()!));
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
    yield* streamTransformer.bind(task());
  }
}

