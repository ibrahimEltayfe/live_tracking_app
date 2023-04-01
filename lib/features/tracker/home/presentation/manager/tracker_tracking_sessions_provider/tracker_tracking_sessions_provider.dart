import 'dart:developer';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/shared/enums/session_state_enum.dart';
import '../../../../../home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import '../../../data/repositories/tracker_tracking_sessions_repo.dart';
part 'tracker_tracking_sessions_state.dart';

final trackerTrackingSessionsProvider = StateNotifierProvider.autoDispose<TrackerTrackingSessionsProvider,TrackerTrackingSessionsState>(
  (ref){
    final String clientId = ref.watch(userDataProvider.notifier).userModel!.id!;

    return TrackerTrackingSessionsProvider(ref.read(trackerTrackingSessionsRepositoryProvider))
      ..getAllSessions(clientId);
  }
);

class TrackerTrackingSessionsProvider extends StateNotifier<TrackerTrackingSessionsState> {
  final TrackerTrackingSessionsRepository _trackingSessionsRepository;
  TrackerTrackingSessionsProvider(this._trackingSessionsRepository) : super(TrackerTrackingSessionsInitial());

  List<TrackingSessionModel> sessions = [];

  Future getAllSessions(String trackerId) async{
    state = TrackerTrackingSessionsLoading();

    //todo:tracker id
    final results = await _trackingSessionsRepository.getAllSessions(trackerId);

    results.fold(
      (failure){
        state = TrackerTrackingSessionsError(failure.message);
      },
      (results){
        sessions = results;
        state = TrackerTrackingSessionsDataFetched();
      }
    );
  }
  
  void addSessionToList(TrackingSessionModel trackingSessionModel){

    sessions.add(trackingSessionModel);
    state = TrackerTrackingSessionsDataFetched();
  }
  
  void deleteFromSessionsList(String sessionId){
    int index = sessions.indexWhere((element) => element.id == sessionId);
    sessions.removeAt(index);
    state = TrackerTrackingSessionsDataFetched();
  }

  void disableSessionInList(String sessionId){
    int index = sessions.indexWhere((element) => element.id == sessionId);
    sessions[index].state = SessionState.disabled;

    state = TrackerTrackingSessionsDataFetched();
  }

  void enableSessionInList(String sessionId){
    int index = sessions.indexWhere((element) => element.id == sessionId);
    sessions[index].state = SessionState.active;
    state = TrackerTrackingSessionsDataFetched();
  }


}
