import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../../config/providers.dart';
import '../../../data/repositories/email_verification_repo.dart';
part 'send_email_verification_state.dart';

final sendEmailVerificationProvider = StateNotifierProvider.autoDispose<SendEmailVerificationProvider,SendEmailVerificationState>(
     (ref) {
      final emailVerificationRepositoryRef = ref.read(emailVerificationRepositoryProvider);
      return SendEmailVerificationProvider(emailVerificationRepositoryRef);
    }
);

class SendEmailVerificationProvider extends StateNotifier<SendEmailVerificationState> {
  EmailVerificationRepository emailVerificationRepository;
  SendEmailVerificationProvider(this.emailVerificationRepository) : super(SendEmailVerificationInitial());

  Future sendEmailVerification() async{
    state = SendEmailVerificationLoading();
    final results = await emailVerificationRepository.sendEmailVerification();

    results.fold(
     (failure){
      state = SendEmailVerificationError(failure.message);
     },
     (results){
       state = SendEmailVerificationDone();
     }
   );
  }
}
