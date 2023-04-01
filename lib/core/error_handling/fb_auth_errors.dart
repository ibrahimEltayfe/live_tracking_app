import '../shared/no_context_localization.dart';

class FBAuthErrorMsgs {

  static String getLoginErrorMessage(String code) {
    final localization = noContextLocalization();

    switch (code) {
      case 'user-disabled':
        return localization.userDisabled;
      case 'user-not-found':
        return localization.userNotFound;
      case 'wrong-password':
        return localization.wrongPassword;
      case 'invalid-email':
        return localization.invalidEmail;
      default:
        return localization.loginDefaultError;
    }
  }

  static String getRegisterErrorMessage(String code){
    final localization = noContextLocalization();

    switch (code) {
      case 'operation_not_allowed':
        return localization.operationNotAllowed;
      case 'weak_password':
        return localization.weakPassword;
      case 'invalid_email':
        return localization.invalidEmail;
      case 'email-already-in-use':
        return localization.emailAlreadyInUse;
      case 'invalid_credential':
        return localization.invalidCredential;
      default:
        return localization.registerDefaultError;
    }
}

  static String getCredentialErrorMessage(String code) {
    final localization = noContextLocalization();

    switch (code) {
      case 'account-exists-with-different-credential':
        return localization.accountExistsWithDifferentCredential;
      case 'invalid-credential':
        return localization.invalidCredential;
      case 'operation-not-allowed':
        return localization.operationNotAllowed;
      case 'user-disabled':
        return localization.userDisabled;
      case 'user-not-found':
        return localization.userNotFound;
      case 'wrong-password':
        return localization.wrongPassword;
      case 'invalid-verification-code':
        return localization.invalidVerificationCode;
      case 'invalid-verification-id':
        return localization.invalidVerificationId;
      default:
        return localization.credentialDefaultError;
    }
  }

  static getResetPasswordErrorMessage(String code){
    final localization = noContextLocalization();

    switch (code) {
      case 'expired_action_code':
        return localization.expiredActionCode;
      case 'invalid_action_code':
        return localization.invalidActionCode;
      case 'user_disabled':
        return localization.userDisabled;
      case 'user_not_found':
        return localization.userNotFound;
      case 'weak_password':
        return localization.weakPassword;
      case 'error_invalid_email':
        return localization.invalidEmail;
      case 'error_user_not_found':
        return localization.errorUserNotFound;
      default:
        return localization.resetPasswordDefaultError;
    }
  }
}

enum AuthMethod{
  register,
  login,
  credential,
  resetPassword,
}

extension AuthErrorMessagesHandler on AuthMethod{
  String getAuthError(String code){
    switch(this) {
      case AuthMethod.register: return FBAuthErrorMsgs.getRegisterErrorMessage(code);
      case AuthMethod.login: return FBAuthErrorMsgs.getLoginErrorMessage(code);
      case AuthMethod.credential: return FBAuthErrorMsgs.getCredentialErrorMessage(code);
      case AuthMethod.resetPassword: return FBAuthErrorMsgs.getResetPasswordErrorMessage(code);
    }
  }
}