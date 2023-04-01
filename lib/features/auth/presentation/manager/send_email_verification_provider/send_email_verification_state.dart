part of 'send_email_verification_provider.dart';

abstract class SendEmailVerificationState extends Equatable {
  const SendEmailVerificationState();

  @override
  List<Object> get props => [];
}

class SendEmailVerificationInitial extends SendEmailVerificationState {}

class SendEmailVerificationLoading extends SendEmailVerificationState {}

class SendEmailVerificationDone extends SendEmailVerificationState {}

class SendEmailVerificationError extends SendEmailVerificationState {
  final String message;
  const SendEmailVerificationError(this.message);

  @override
  List<Object> get props => [message];
}