import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

extension LocalizationHelper on BuildContext{
  AppLocalizations get localization => AppLocalizations.of(this)!;
  bool get isRtl => Localizations.localeOf(this).languageCode == 'ar';
}

