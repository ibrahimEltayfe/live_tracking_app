part of 'user_data_provider.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataFetched extends UserDataState {}

class UserDataError extends UserDataState {
  final Failure failure;
  const UserDataError(this.failure);

  @override
  List<Object> get props => [failure];
}