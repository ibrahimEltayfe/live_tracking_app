import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:riverpod/riverpod.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/email_verification_repo.dart';
part 'login_state.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginProvider,LoginState>(
  (ref){

    return LoginProvider(ref.read(authRepositoryProvider),ref.read(emailVerificationRepositoryProvider));
   }
);

class LoginProvider extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  final EmailVerificationRepository _emailVerificationRepository;

  LoginProvider(this._authRepository,this._emailVerificationRepository) : super(LoginInitial());

  Future login(String email,String password,UserType userType) async{
    state = LoginLoading();

    final results = await _authRepository.loginWithEmail(
        email: email,
        password: password
    );

    await results.fold(
     (failure){
       log(failure.toString());
       state = LoginError(failure.message);
     },
     (_) async{
       final isEmailVerified = await _emailVerificationRepository.isEmailVerified();

       isEmailVerified.fold((failure){
         state = LoginError(failure.message);
       }, (isVerified) async{
         state = LoginSuccess(isEmailVerified:isVerified);
       });

     });

  }

}
