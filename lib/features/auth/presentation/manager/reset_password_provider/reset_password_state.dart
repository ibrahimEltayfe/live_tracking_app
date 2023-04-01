part of 'reset_password_provider.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordLinkSent extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message);

  @override
  List<Object> get props => [message];
}