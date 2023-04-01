part of 'login_provider.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
 final bool isEmailVerified;
 const LoginSuccess({required this.isEmailVerified});

 @override
 List<Object> get props => [isEmailVerified];
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}