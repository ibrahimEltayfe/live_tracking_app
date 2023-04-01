part of 'check_email_verification_provider.dart';

abstract class CheckEmailVerificationState extends Equatable {
  const CheckEmailVerificationState();

  @override
  List<Object> get props => [];
}

class CheckEmailVerificationInitial extends CheckEmailVerificationState {}

class CheckEmailVerificationLoading extends CheckEmailVerificationState {}

class CheckEmailVerifiedSuccessfully extends CheckEmailVerificationState {}

class CheckEmailVerificationError extends CheckEmailVerificationState {
  final String message;
  const CheckEmailVerificationError(this.message);

  @override
  List<Object> get props => [message];
}