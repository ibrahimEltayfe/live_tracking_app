part of 'client_tracking_sessions_provider.dart';

abstract class ClientTrackingSessionsState extends Equatable {
  const ClientTrackingSessionsState();

  @override
  List<Object> get props => [];
}

class ClientTrackingSessionsInitial extends ClientTrackingSessionsState {}

class ClientTrackingSessionsLoading extends ClientTrackingSessionsState {}

class ClientTrackingSessionsDataFetched extends ClientTrackingSessionsState {}

class ClientTrackingSessionsError extends ClientTrackingSessionsState {
  final String message;
  const ClientTrackingSessionsError(this.message);

  @override
  List<Object> get props => [message];
}