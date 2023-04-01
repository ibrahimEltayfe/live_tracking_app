part of 'social_login_provider.dart';

abstract class SocialLoginState extends Equatable {
  const SocialLoginState();

  @override
  List<Object> get props => [];
}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {}

class SocialLoginUserNotExist extends SocialLoginState {}

class SocialLoginError extends SocialLoginState {
  final String message;
  const SocialLoginError(this.message);

  @override
  List<Object> get props => [message];
}