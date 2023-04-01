import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/features/profile/data/repositories/profile_user_repo.dart';
import 'package:riverpod/riverpod.dart';

import '../../../client/home/presentation/manager/location_updater_provider/location_updater_provider.dart';
part 'profile_user_state.dart';

final profileUserProvider = StateNotifierProvider.autoDispose<ProfileUserProvider,ProfileUserState>(
  (ref) => ProfileUserProvider(ref.read(profileUserRepositoryProvider))
);

class ProfileUserProvider extends StateNotifier<ProfileUserState> {
  final ProfileUserRepository _profileUserRepository;
  ProfileUserProvider(this._profileUserRepository) : super(ProfileUserInitial());

  Future signOut() async{
    state = ProfileUserLoading();
    final results = await _profileUserRepository.signOut();

    results.fold(
      (failure){
        state = ProfileUserError(failure.message);
      },
      (results){
        state = ProfileUserSignedOut();
      }
    );
  }
}
