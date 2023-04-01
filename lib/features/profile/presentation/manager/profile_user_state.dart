part of 'profile_user_provider.dart';

abstract class ProfileUserState extends Equatable {
  const ProfileUserState();

  @override
  List<Object> get props => [];
}

class ProfileUserInitial extends ProfileUserState {}

class ProfileUserLoading extends ProfileUserState {}

class ProfileUserDataFetched extends ProfileUserState {}

class ProfileUserSignedOut extends ProfileUserState {}

class ProfileUserError extends ProfileUserState {
  final String message;
  const ProfileUserError(this.message);

  @override
  List<Object> get props => [message];
}