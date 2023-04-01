import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get enterYourEmail => 'Enter you email';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get doNotHaveAnAccount => 'Do not have an account? ';

  @override
  String get alreadyHaveAnAccount => 'Do you have an account? ';

  @override
  String get or => 'OR';

  @override
  String get resetPassword => 'Reset Your Password';

  @override
  String get verifyEmailMessage => 'Please click on the link sent to your email to verify.';

  @override
  String get done => 'Done';

  @override
  String get addSession => 'Add Session';

  @override
  String get sessionPassword => 'Session Password';

  @override
  String get sessionName => 'Session Name';

  @override
  String get intervals => 'Update Location Every(in seconds):';

  @override
  String get name => 'Name';

  @override
  String get changePassword => 'Change Password';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get appSetting => 'App Setting';

  @override
  String get about => 'About';

  @override
  String get logout => 'Logout';

  @override
  String get trackingSessions => 'Tracking Sessions';

  @override
  String get unExpectedError => 'something went wrong, please try again later.';

  @override
  String get noInternetError => 'no internet';

  @override
  String get noUIDError => 'session ended, please login.';

  @override
  String get pickFileError => 'failed picking a file.';

  @override
  String get dioBadRequest => 'bad request, Try again later';

  @override
  String get dioUnAuthorized => 'user is un authorized';

  @override
  String get dioForbidden => 'server rejected the request, Try again later';

  @override
  String get dioRequestTimeout => 'time out, please try again later';

  @override
  String get dioInternalServerError => 'server error, please try again later';

  @override
  String get dioNotFound => 'page not found, please try again later';

  @override
  String get userDisabled => 'This user has been disabled. contact support for help.';

  @override
  String get userNotFound => 'Email is not found.';

  @override
  String get wrongPassword => 'Incorrect password, please try again.';

  @override
  String get loginDefaultError => 'Login Error.. please try again';

  @override
  String get weakPassword => 'the password is not strong enough.';

  @override
  String get invalidEmail => 'the email address is malformed.';

  @override
  String get emailAlreadyInUse => 'the email is already in use by a different account.';

  @override
  String get registerDefaultError => 'Register Error.. please try again';

  @override
  String get accountExistsWithDifferentCredential => 'Account exists with different credentials.';

  @override
  String get invalidCredential => 'The credential received is malformed or has expired.';

  @override
  String get operationNotAllowed => 'Operation is not allowed. Please contact support.';

  @override
  String get invalidVerificationCode => 'The credential verification code received is invalid.';

  @override
  String get invalidVerificationId => 'The credential verification ID received is invalid.';

  @override
  String get credentialDefaultError => 'something went wrong.. please try again';

  @override
  String get expiredActionCode => 'the password reset code has expired.';

  @override
  String get invalidActionCode => 'the password reset code is invalid.';

  @override
  String get userDisabledResetPassword => 'the user corresponding to the given password reset code has been disabled.';

  @override
  String get userNotFoundResetPassword => 'there is no user corresponding to the password reset code.';

  @override
  String get resetPasswordDefaultError => 'Error when resetting your password.. please try again';

  @override
  String get errorUserNotFound => 'there is no user corresponding to the given email address.';

  @override
  String get emailIsEmptyError => 'please enter your email';

  @override
  String get passwordIsEmptyError => 'please enter your password';

  @override
  String get nameIsEmptyError => 'please enter your name';

  @override
  String get fieldIsEmptyError => 'this field is required';

  @override
  String passwordLengthError(Object length) {
    return 'please enter at least $length letters';
  }

  @override
  String nameLengthError(Object length) {
    return 'this field can not exceed $length letters';
  }

  @override
  String sessionPasswordLengthError(Object length) {
    return 'please enter at least $length letters';
  }

  @override
  String sessionNameLengthError(Object length) {
    return 'this field can not exceed $length letters';
  }

  @override
  String get sessionPasswordIsEmptyError => 'please enter a session password';

  @override
  String get sessionNameIsEmptyError => 'please enter a session name';

  @override
  String get sessionNameIsUsedError => 'this name is used, please try another one.';

  @override
  String get emailNotVerified => 'Email is not verified';

  @override
  String get sendingVerificationEmail => 'Sending the verification link to your email..';

  @override
  String get resetPasswordLinkSent => 'Your reset password link sent to your account.';

  @override
  String get noDataError => 'No Data Found.';
}
