part of 'tracker_tracking_sessions_provider.dart';

abstract class TrackerTrackingSessionsState extends Equatable {
  const TrackerTrackingSessionsState();

  @override
  List<Object> get props => [];
}

class TrackerTrackingSessionsInitial extends TrackerTrackingSessionsState {}

class TrackerTrackingSessionsLoading extends TrackerTrackingSessionsState {}

class TrackerTrackingSessionsDataFetched extends TrackerTrackingSessionsState {}

class TrackerTrackingSessionsError extends TrackerTrackingSessionsState {
  final String message;
  const TrackerTrackingSessionsError(this.message);

  @override
  List<Object> get props => [message];
}