import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../data/repositories/user_data_repo.dart';
part 'user_data_state.dart';

final userDataProvider = StateNotifierProvider.autoDispose<UserDataProvider,UserDataState>(
  (ref) => UserDataProvider(ref.read(userDataRepositoryProvider))..fetchUserData()
);

class UserDataProvider extends StateNotifier<UserDataState> {
  final UserDataRepository _userDataRepositoryProvider;
  UserDataProvider(this._userDataRepositoryProvider) : super(UserDataInitial());

  UserModel? userModel;

  Future<void> fetchUserData() async{
    state = UserDataLoading();

    final results = await _userDataRepositoryProvider.getUserData();
    results.fold(
      (failure){
        state = UserDataError(failure);
      },
      (results){
        userModel = results;
        state = UserDataFetched();
      }
    );

  }

}
