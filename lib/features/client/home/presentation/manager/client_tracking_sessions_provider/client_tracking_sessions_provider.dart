import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:flutter_projects/features/client/home/presentation/manager/location_updater_provider/location_updater_provider.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../../../home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import '../../../data/repositories/client_tracking_sessions_repo.dart';
part 'client_tracking_sessions_state.dart';

final clientTrackingSessionsProvider = StateNotifierProvider.autoDispose<ClientTrackingSessionsProvider,ClientTrackingSessionsState>(
  (ref){
    //assign a listener so the location updater does not fire dispose at start, so it can cancel timers when dispose
    ref.watch(locationUpdaterProvider);

    final String clientId = ref.watch(userDataProvider.notifier).userModel!.id!;

    return ClientTrackingSessionsProvider(ref.read(clientTrackingSessionsRepositoryProvider),ref.read(locationUpdaterProvider))
    ..getAllSessions(clientId);
  }
);

class ClientTrackingSessionsProvider extends StateNotifier<ClientTrackingSessionsState> {
  final ClientTrackingSessionsRepository _trackingSessionsRepository;
  final LocationUpdaterProvider _locationUpdaterProvider;
  ClientTrackingSessionsProvider(this._trackingSessionsRepository,this._locationUpdaterProvider) : super(ClientTrackingSessionsInitial());

  late final StreamSubscription _sessionsStreamSub;
  List<TrackingSessionModel> sessions = [];

  Future<void> getAllSessions(String clientId) async{
    state = ClientTrackingSessionsLoading();

    final resultsStream = _trackingSessionsRepository.getAllSessions(clientId);
    _sessionsStreamSub = resultsStream.listen((event) {});

    _sessionsStreamSub.onData((data) {
      log(data.toString());
      sessions = data;
      _locationUpdaterProvider.locationUpdateHandler(sessions);
      state = ClientTrackingSessionsDataFetched();
    });

    _sessionsStreamSub.onError((e,s){
      final Failure failure;

      if(e is Failure){
        failure = e;
      }else{
        failure = UnExpectedFailure();
      }

      state = ClientTrackingSessionsError(failure.message);
    });

    _sessionsStreamSub.onDone(() {
      log('stream ended');//todo:
    });

  }

  @override
  void dispose() {
    _sessionsStreamSub.cancel();
    super.dispose();
  }

}
