import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../../../config/providers.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../../core/shared/models/client_location_model.dart';
import '../../../data/repositories/tracker_tracking_sessions_repo.dart';
import '../tracker_tracking_sessions_provider/tracker_tracking_sessions_provider.dart';
part 'tracker_add_session_state.dart';

final trackerAddSessionProvider = StateNotifierProvider.autoDispose<TrackerAddSessionProvider,TrackerAddSessionState>(
  (ref){
    return TrackerAddSessionProvider(
        ref.read(trackerTrackingSessionsRepositoryProvider),
        ref.read(trackerTrackingSessionsProvider.notifier)
    );
  }
);

class TrackerAddSessionProvider extends StateNotifier<TrackerAddSessionState> {
  final TrackerTrackingSessionsRepository _trackerTrackingSessionRepository;
  final TrackerTrackingSessionsProvider _trackerTrackingSessions;
  TrackerAddSessionProvider(this._trackerTrackingSessionRepository,this._trackerTrackingSessions) : super(TrackerAddSessionInitial());

  Future<void> addSession(TrackingSessionModel trackingSessionModel) async{

    state = TrackerAddSessionLoading();

    final ClientLocationModel clientLocationModel = ClientLocationModel(
      lat: null,
      lon: null,
      time: DateTime.now()
    );

    final String unEncryptedPassword = trackingSessionModel.sessionPassword!;

    final addSessionResults = await _trackerTrackingSessionRepository.addSession(
        trackingSessionModel,
        clientLocationModel
    );

    addSessionResults.fold(
       (failure){
          state = TrackerAddSessionError(failure);
        },
        (_){
          state = TrackerAddSessionDone();
          //add to sessions list and update the ui
          trackingSessionModel.sessionPassword = unEncryptedPassword;
          _trackerTrackingSessions.addSessionToList(trackingSessionModel);
        }
    );
  }

  void refreshState(){
    state = TrackerAddSessionInitial();
  }


}
