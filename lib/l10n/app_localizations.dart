import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter you email'**
  String get enterYourEmail;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @doNotHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do not have an account? '**
  String get doNotHaveAnAccount;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you have an account? '**
  String get alreadyHaveAnAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get resetPassword;

  /// No description provided for @verifyEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'Please click on the link sent to your email to verify.'**
  String get verifyEmailMessage;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @addSession.
  ///
  /// In en, this message translates to:
  /// **'Add Session'**
  String get addSession;

  /// No description provided for @sessionPassword.
  ///
  /// In en, this message translates to:
  /// **'Session Password'**
  String get sessionPassword;

  /// No description provided for @sessionName.
  ///
  /// In en, this message translates to:
  /// **'Session Name'**
  String get sessionName;

  /// No description provided for @intervals.
  ///
  /// In en, this message translates to:
  /// **'Update Location Every(in seconds):'**
  String get intervals;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @appSetting.
  ///
  /// In en, this message translates to:
  /// **'App Setting'**
  String get appSetting;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @trackingSessions.
  ///
  /// In en, this message translates to:
  /// **'Tracking Sessions'**
  String get trackingSessions;

  /// No description provided for @unExpectedError.
  ///
  /// In en, this message translates to:
  /// **'something went wrong, please try again later.'**
  String get unExpectedError;

  /// No description provided for @noInternetError.
  ///
  /// In en, this message translates to:
  /// **'no internet'**
  String get noInternetError;

  /// No description provided for @noUIDError.
  ///
  /// In en, this message translates to:
  /// **'session ended, please login.'**
  String get noUIDError;

  /// No description provided for @pickFileError.
  ///
  /// In en, this message translates to:
  /// **'failed picking a file.'**
  String get pickFileError;

  /// No description provided for @dioBadRequest.
  ///
  /// In en, this message translates to:
  /// **'bad request, Try again later'**
  String get dioBadRequest;

  /// No description provided for @dioUnAuthorized.
  ///
  /// In en, this message translates to:
  /// **'user is un authorized'**
  String get dioUnAuthorized;

  /// No description provided for @dioForbidden.
  ///
  /// In en, this message translates to:
  /// **'server rejected the request, Try again later'**
  String get dioForbidden;

  /// No description provided for @dioRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'time out, please try again later'**
  String get dioRequestTimeout;

  /// No description provided for @dioInternalServerError.
  ///
  /// In en, this message translates to:
  /// **'server error, please try again later'**
  String get dioInternalServerError;

  /// No description provided for @dioNotFound.
  ///
  /// In en, this message translates to:
  /// **'page not found, please try again later'**
  String get dioNotFound;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user has been disabled. contact support for help.'**
  String get userDisabled;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email is not found.'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password, please try again.'**
  String get wrongPassword;

  /// No description provided for @loginDefaultError.
  ///
  /// In en, this message translates to:
  /// **'Login Error.. please try again'**
  String get loginDefaultError;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'the password is not strong enough.'**
  String get weakPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'the email address is malformed.'**
  String get invalidEmail;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'the email is already in use by a different account.'**
  String get emailAlreadyInUse;

  /// No description provided for @registerDefaultError.
  ///
  /// In en, this message translates to:
  /// **'Register Error.. please try again'**
  String get registerDefaultError;

  /// No description provided for @accountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'Account exists with different credentials.'**
  String get accountExistsWithDifferentCredential;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The credential received is malformed or has expired.'**
  String get invalidCredential;

  /// No description provided for @operationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation is not allowed. Please contact support.'**
  String get operationNotAllowed;

  /// No description provided for @invalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'The credential verification code received is invalid.'**
  String get invalidVerificationCode;

  /// No description provided for @invalidVerificationId.
  ///
  /// In en, this message translates to:
  /// **'The credential verification ID received is invalid.'**
  String get invalidVerificationId;

  /// No description provided for @credentialDefaultError.
  ///
  /// In en, this message translates to:
  /// **'something went wrong.. please try again'**
  String get credentialDefaultError;

  /// No description provided for @expiredActionCode.
  ///
  /// In en, this message translates to:
  /// **'the password reset code has expired.'**
  String get expiredActionCode;

  /// No description provided for @invalidActionCode.
  ///
  /// In en, this message translates to:
  /// **'the password reset code is invalid.'**
  String get invalidActionCode;

  /// No description provided for @userDisabledResetPassword.
  ///
  /// In en, this message translates to:
  /// **'the user corresponding to the given password reset code has been disabled.'**
  String get userDisabledResetPassword;

  /// No description provided for @userNotFoundResetPassword.
  ///
  /// In en, this message translates to:
  /// **'there is no user corresponding to the password reset code.'**
  String get userNotFoundResetPassword;

  /// No description provided for @resetPasswordDefaultError.
  ///
  /// In en, this message translates to:
  /// **'Error when resetting your password.. please try again'**
  String get resetPasswordDefaultError;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'there is no user corresponding to the given email address.'**
  String get errorUserNotFound;

  /// No description provided for @emailIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'please enter your email'**
  String get emailIsEmptyError;

  /// No description provided for @passwordIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'please enter your password'**
  String get passwordIsEmptyError;

  /// No description provided for @nameIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'please enter your name'**
  String get nameIsEmptyError;

  /// No description provided for @fieldIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'this field is required'**
  String get fieldIsEmptyError;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'please enter at least {length} letters'**
  String passwordLengthError(Object length);

  /// No description provided for @nameLengthError.
  ///
  /// In en, this message translates to:
  /// **'this field can not exceed {length} letters'**
  String nameLengthError(Object length);

  /// No description provided for @sessionPasswordLengthError.
  ///
  /// In en, this message translates to:
  /// **'please enter at least {length} letters'**
  String sessionPasswordLengthError(Object length);

  /// No description provided for @sessionNameLengthError.
  ///
  /// In en, this message translates to:
  /// **'this field can not exceed {length} letters'**
  String sessionNameLengthError(Object length);

  /// No description provided for @sessionPasswordIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'please enter a session password'**
  String get sessionPasswordIsEmptyError;

  /// No description provided for @sessionNameIsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'please enter a session name'**
  String get sessionNameIsEmptyError;

  /// No description provided for @sessionNameIsUsedError.
  ///
  /// In en, this message translates to:
  /// **'this name is used, please try another one.'**
  String get sessionNameIsUsedError;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email is not verified'**
  String get emailNotVerified;

  /// No description provided for @sendingVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Sending the verification link to your email..'**
  String get sendingVerificationEmail;

  /// No description provided for @resetPasswordLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Your reset password link sent to your account.'**
  String get resetPasswordLinkSent;

  /// No description provided for @noDataError.
  ///
  /// In en, this message translates to:
  /// **'No Data Found.'**
  String get noDataError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
