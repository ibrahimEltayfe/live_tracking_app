import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:riverpod/riverpod.dart';
import '../../../data/repositories/auth_repository.dart';
part 'social_login_state.dart';

final socialLoginProvider = StateNotifierProvider.autoDispose<SocialLoginProvider,SocialLoginState>(
  (ref){
    return SocialLoginProvider(ref.read(authRepositoryProvider));
   }
);

class SocialLoginProvider extends StateNotifier<SocialLoginState> {
  AuthRepository authRepository;

  SocialLoginProvider(this.authRepository) : super(SocialLoginInitial());

  Future loginWithGoogle() async{
    state = SocialLoginLoading();

    final results = await authRepository.loginWithGoogle();

    await results.fold(
     (failure){
       state = SocialLoginError(failure.message);
     },
     (isExist) async{
       if(isExist){
         state = SocialLoginSuccess();
       }else{
         state = SocialLoginUserNotExist();
       }
     });

  }

  Future registerWithGoogle(UserType userType) async{
    state = SocialLoginLoading();

    final results = await authRepository.registerWithGoogle(userType);

    await results.fold(
        (failure){
          state = SocialLoginError(failure.message);
        },
        (_) async{
          state = SocialLoginSuccess();
        });

  }

}
