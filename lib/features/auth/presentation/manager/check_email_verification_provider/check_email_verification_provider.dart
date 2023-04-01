import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../../core/shared/no_context_localization.dart';
import '../../../data/repositories/email_verification_repo.dart';
part 'check_email_verification_state.dart';

final checkEmailVerificationProvider = StateNotifierProvider.autoDispose<CheckEmailVerificationProvider,CheckEmailVerificationState>(
  (ref){
    return CheckEmailVerificationProvider(ref.read(emailVerificationRepositoryProvider));
  }
);

class CheckEmailVerificationProvider extends StateNotifier<CheckEmailVerificationState> {
  EmailVerificationRepository emailVerificationRepository;
  CheckEmailVerificationProvider(this.emailVerificationRepository) : super(CheckEmailVerificationInitial());

  Future<void> isEmailVerified() async{
    state = CheckEmailVerificationLoading();

    final results = await emailVerificationRepository.isEmailVerified();

    results.fold(
      (failure){
        state = CheckEmailVerificationError(failure.message);
      },
      (isVerified){
        if(isVerified){
          state = CheckEmailVerifiedSuccessfully();
        }else{
          state = CheckEmailVerificationError(noContextLocalization().emailNotVerified);
        }
      }
    );
  }
  
}
