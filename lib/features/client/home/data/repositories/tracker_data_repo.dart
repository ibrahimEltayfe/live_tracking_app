import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handling/exceptions.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../../core/utils/network_checker.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../data_sources/tracker_data_remote.dart';

abstract class TrackersDataRepository{
  Stream getTrackerData(String trackerId);
}

class TrackersDataRepositoryImpl implements TrackersDataRepository{
  final TrackerDataRemote _trackersDataRemote;
  final NetworkInfo _connectionChecker;
  const TrackersDataRepositoryImpl(this._trackersDataRemote, this._connectionChecker);

  @override
  Stream getTrackerData(String trackerId) async*{
    if(trackerId.isEmpty){
      yield null;
      return;
    }

    StreamTransformer streamTransformer = StreamTransformer<QuerySnapshot<Map<String, dynamic>>, UserModel>
        .fromHandlers(
      handleData: (QuerySnapshot<Map<String, dynamic>> event, EventSink sink) {
        log(event.docs.length.toString());

        sink.add(UserModel.fromJson(event.docs.first.data()));

      },
      handleError: (Object e, StackTrace stacktrace, EventSink sink) async{
        log(e.toString());

        if(!(await _connectionChecker.isConnected)) {
          sink.addError(NoInternetFailure());
          return;
        }
        sink.addError(ExceptionHandler.handle(e).failure);

      },
      handleDone: (EventSink sink) => sink.close(),
    );

    yield* streamTransformer.bind(_trackersDataRemote.getTrackerData(trackerId));

  }


}