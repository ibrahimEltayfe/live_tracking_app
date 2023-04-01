import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

AppLocalizations noContextLocalization() {
  return AppLocalizations.of(navigatorKey.currentContext!)!;
}