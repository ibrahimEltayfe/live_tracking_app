part of 'tracker_add_session_provider.dart';

abstract class TrackerAddSessionState extends Equatable {
  const TrackerAddSessionState();

  @override
  List<Object> get props => [];
}

class TrackerAddSessionInitial extends TrackerAddSessionState {}

class TrackerAddSessionLoading extends TrackerAddSessionState {}

class TrackerAddSessionDone extends TrackerAddSessionState {}

class TrackerAddSessionError extends TrackerAddSessionState {
  final Failure failure;
  const TrackerAddSessionError(this.failure);

  @override
  List<Object> get props => [Failure];
}