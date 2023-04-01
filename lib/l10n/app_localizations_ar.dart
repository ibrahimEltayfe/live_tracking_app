import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get email => 'البريد الإلكترونى';

  @override
  String get password => 'كلمة السر';

  @override
  String get forgotPassword => 'نسيت كلمة السر';

  @override
  String get enterYourEmail => 'اكتب بريدك الإلكترونى';

  @override
  String get login => 'دخول';

  @override
  String get register => 'تسجيل';

  @override
  String get doNotHaveAnAccount => 'لا تمتلك حساب؟';

  @override
  String get alreadyHaveAnAccount => 'هل تمتلك حساب؟';

  @override
  String get or => 'أو';

  @override
  String get resetPassword => 'إعادة تعيين كلمة السر';

  @override
  String get verifyEmailMessage => 'من فضلك إضغط على الرابط الذى تم إرساله إلى بريدك الإلكترونى للتفعيل';

  @override
  String get done => 'تم';

  @override
  String get addSession => 'إضافة جلسة';

  @override
  String get sessionPassword => 'كلمة المرور';

  @override
  String get sessionName => 'اسم الجلسة';

  @override
  String get intervals => 'تحديث بيانات الموقع كل (بالثانية):';

  @override
  String get name => 'الاسم';

  @override
  String get changePassword => 'تغيير كلمة السر';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get appSetting => 'إعدادات التطبيق';

  @override
  String get about => 'حول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get trackingSessions => 'جلسات التتبع';

  @override
  String get unExpectedError => 'حدث خطأ, برجاء المحاولة مرة اخرى.';

  @override
  String get noInternetError => 'لا يوجد انترنت';

  @override
  String get noUIDError => 'انتهت صلاحية الجلسة, برجاء تسجيل الدخول';

  @override
  String get pickFileError => 'حدث خطأ, لم نتمكن من جلب الملف';

  @override
  String get dioBadRequest => 'حدث خطأ عند إرسال الطلب';

  @override
  String get dioUnAuthorized => 'طلب غير مصرح به';

  @override
  String get dioForbidden => 'السيرفر رفض الطلب, برجاء المحاولة مرة اخرى';

  @override
  String get dioRequestTimeout => 'الطلب اخذ وقتا كثيرا, برجاء المحاولة مرة اخرى';

  @override
  String get dioInternalServerError => 'هناك خطأ بالسيرفر, برجاء المحاولة مرة اخرى';

  @override
  String get dioNotFound => 'الصفحة غير موجودة, برجاء المحاولة مرة اخرى';

  @override
  String get userDisabled => 'هذا الحساب متوقف, برجاء مراسلتنا لمعرفة السبب.';

  @override
  String get userNotFound => 'البريد الالكترونى غير موجود.';

  @override
  String get wrongPassword => 'كلمة مرور غير صحيحة';

  @override
  String get loginDefaultError => 'حدث خطأ عند تسجيل الدخول, برجاء المحاولة مرة اخرى';

  @override
  String get weakPassword => 'كلمة السر ليست قوية';

  @override
  String get invalidEmail => 'البريد الالكترونى غير صالح';

  @override
  String get emailAlreadyInUse => 'البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب مختلف';

  @override
  String get registerDefaultError => 'حدث خطأ عند التسجيل, برجاء المحاولة مرة اخرى';

  @override
  String get accountExistsWithDifferentCredential => 'الحساب موجود ببيانات مختلفة';

  @override
  String get invalidCredential => 'البيانات المتلقاة غير صحيحة أو منتهية الصلاحية';

  @override
  String get operationNotAllowed => 'العملية غير مسموح بها';

  @override
  String get invalidVerificationCode => 'رمز التحقق غير صالح.';

  @override
  String get invalidVerificationId => 'رمز التحقق من البيانات غير صالح';

  @override
  String get credentialDefaultError => 'حدث خطأ, برجاء المحاولة مرة اخرى';

  @override
  String get expiredActionCode => 'انتهت صلاحية رمز إعادة تعيين كلمة المرور';

  @override
  String get invalidActionCode => 'رمز إعادة تعيين كلمة المرور غير صالح.';

  @override
  String get userDisabledResetPassword => 'البريد الالكترونى التابع لهذا الرمز متوقف.';

  @override
  String get userNotFoundResetPassword => 'لا يوجد مستخدم مطابق لرمز إعادة تعيين كلمة المرور.';

  @override
  String get resetPasswordDefaultError => 'خطأ عند إعادة تعيين كلمة المرور الخاصة بك .. يرجى المحاولة مرة أخرى';

  @override
  String get errorUserNotFound => 'لا يوجد مستخدم مطابق لعنوان البريد الإلكتروني المحدد.';

  @override
  String get emailIsEmptyError => 'من فضلك ادخل البريد الإلكترونى';

  @override
  String get passwordIsEmptyError => 'من فضلك ادخل كلمة السر';

  @override
  String get nameIsEmptyError => 'من فضلك ادخل اسمك';

  @override
  String get fieldIsEmptyError => 'هذا الحقل مطلوب';

  @override
  String passwordLengthError(Object length) {
    return 'من فضلك ادخل على الأقل $length أرقام أو حروف';
  }

  @override
  String nameLengthError(Object length) {
    return 'هذا الحقل يجب أن لا يتعدى $length حرف';
  }

  @override
  String sessionPasswordLengthError(Object length) {
    return 'من فضلك ادخل على الأقل $length أرقام أو حروف';
  }

  @override
  String sessionNameLengthError(Object length) {
    return 'هذا الحقل يجب أن لا يتعدى $length حرف';
  }

  @override
  String get sessionPasswordIsEmptyError => 'من فضلك ادخل كلمة سر للجلسة';

  @override
  String get sessionNameIsEmptyError => 'من فضلك ادخل اسم للجلسة';

  @override
  String get sessionNameIsUsedError => 'هذا الاسم مستخدم, من فضلك ادخل اسم اخر';

  @override
  String get emailNotVerified => 'البريد الإلكترونى غير مفعل';

  @override
  String get sendingVerificationEmail => 'يتم إرسال رابط التفعيل لبريدك الإلكترونى.. ';

  @override
  String get resetPasswordLinkSent => 'تم إرسال رابط إعادة تعيين كلمة المرور الخاصة بك الى بريدك الإلكترونى';

  @override
  String get noDataError => 'لا توجد معلومات حالية.';
}
