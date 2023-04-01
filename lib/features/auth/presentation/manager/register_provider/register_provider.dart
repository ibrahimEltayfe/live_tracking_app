import 'package:equatable/equatable.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:riverpod/riverpod.dart';
import '../../../data/repositories/auth_repository.dart';
part 'register_state.dart';

final registerProvider = StateNotifierProvider.autoDispose<RegisterProvider,RegisterState>(
  (ref){
    return RegisterProvider(ref.read(authRepositoryProvider));
   }
);

class RegisterProvider extends StateNotifier<RegisterState> {
  AuthRepository authRepository;
  RegisterProvider(this.authRepository) : super(RegisterInitial());

  Future register(String email,String password,UserType userType) async{
    state = RegisterLoading();

    final results = await authRepository.register(
        email: email,
        password: password,
        userType: userType
    );

    await results.fold(
     (failure){
       state = RegisterError(failure.message);
     },
     (_) async{
       state = RegisterSuccess();
     });

  }

}
