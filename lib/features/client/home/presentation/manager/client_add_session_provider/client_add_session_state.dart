part of 'client_add_session_provider.dart';

abstract class ClientAddSessionState extends Equatable {
  const ClientAddSessionState();

  @override
  List<Object> get props => [];
}

class ClientAddSessionInitial extends ClientAddSessionState {}

class ClientAddSessionLoading extends ClientAddSessionState {}

class ClientAddSessionDone extends ClientAddSessionState {}

class ClientAddSessionError extends ClientAddSessionState {
  final Failure failure;
  const ClientAddSessionError(this.failure);

  @override
  List<Object> get props => [Failure];
}