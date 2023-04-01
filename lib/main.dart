import 'package:flutter/material.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'config/app_routers.dart';
import 'config/app_themes.dart';
import 'core/constants/app_routes.dart';
import 'config/initialize_app_services.dart';
import 'core/shared/enums/app_languages.dart';
import 'core/shared/no_context_localization.dart';
import 'core/shared/providers/language_provider/language_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  final container = ProviderContainer();
  await container.read(initializeAppServicesProvider).init();

  runApp(
   UncontrolledProviderScope(
     container: container,
     child:const MyApp(),
   ));
}


class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider.select((value) => value is LanguageChanged));

    ref.listen(languageProvider, (previous, current) {
      if(current is LanguageError){
        Fluttertoast.showToast(msg: current.message);
      }
    });

    final AppLanguages? currentLang = ref.watch(languageProvider.notifier).appLanguage;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            builder: (context, child) {
              return Theme(
                  data: AppThemes.lightTheme(context,Localizations.localeOf(context)),
                  child: child!
              );
            },

            onGenerateRoute: RoutesManager.routes,
            initialRoute: AppRoutes.decideRoute,

            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (Locale? locale,Iterable<Locale> supportedLocales){
              if(currentLang != null){
                return Locale(currentLang.name);
              }

              return localeCallBack(locale,supportedLocales);
            }

        );
      },

    );
  }

  Locale localeCallBack(Locale? locale,Iterable<Locale> supportedLocales){
    if (locale == null) {
      return const Locale('en');
    }

    for (var supportedLocale in supportedLocales) {
      if (locale.countryCode == supportedLocale.countryCode) {
        return supportedLocale;
      }
    }

    return const Locale('en');
  }

}


