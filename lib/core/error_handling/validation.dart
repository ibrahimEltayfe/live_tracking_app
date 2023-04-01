import 'package:email_validator/email_validator.dart';

import '../shared/no_context_localization.dart';

class Validation {
  String? emailValidator(String? email){
    if(email == null || email.isEmpty) {
      return noContextLocalization().emailIsEmptyError.toString();
    }else if(!EmailValidator.validate(email)){
        return noContextLocalization().invalidEmail;
    }

    return null;
  }

  String? passwordValidator(String? password){
    if(password == null || password.isEmpty) {
      return noContextLocalization().passwordIsEmptyError;
    }else if(password.length < 6) {
      return noContextLocalization().passwordLengthError(6);
    }
    return null;
  }

  String? nameValidator(String? name,{int allowedLength = 20}){
    if(name == null || name.isEmpty) {
      return noContextLocalization().nameIsEmptyError;
    }else if(name.length>=allowedLength) {
      return noContextLocalization().nameLengthError(allowedLength);
    }
    return null;
  }

  String? isPasswordEmpty(String? password){

    if(password == null || password.isEmpty){
      return noContextLocalization().passwordIsEmptyError;
    }

    return null;
  }
}
