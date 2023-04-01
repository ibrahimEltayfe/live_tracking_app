import 'package:flutter/material.dart';
import 'package:flutter_projects/features/auth/presentation/pages/decide_page.dart';
import 'package:flutter_projects/features/auth/presentation/pages/email_verification_check_page.dart';
import 'package:flutter_projects/features/auth/presentation/pages/forgot_password.dart';
import 'package:flutter_projects/features/auth/presentation/pages/login.dart';
import 'package:flutter_projects/features/auth/presentation/pages/register.dart';
import 'package:flutter_projects/features/map/presentation/pages/map_page.dart';
import 'package:flutter_projects/features/profile/presentation/pages/profile_page.dart';
import '../core/constants/app_routes.dart';
import '../features/auth/presentation/pages/social_register_page.dart';
import '../features/home/presentation/pages/home.dart';

class RoutesManager {

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
            builder: (_) => Home(),
            settings: settings
        );

      case AppRoutes.mapRoute:
        return MaterialPageRoute(
            builder: (_) => MapPage(settings.arguments as String),
            settings: settings
        );

      case AppRoutes.decideRoute:
        return MaterialPageRoute(
            builder: (_) => const DecidePage(),
            settings: settings
        );

      case AppRoutes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(),
            settings: settings
        );

      case AppRoutes.registerRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterPage(),
            settings: settings
        );

      case AppRoutes.emailVerificationRoute:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationPage(),
            settings: settings
        );

      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => const ResetPasswordPage(),
            settings: settings
        );


      case AppRoutes.socialRegisterRoute:
        return MaterialPageRoute(
            builder: (_) => const SocialRegisterPage(),
            settings: settings
        );


      case AppRoutes.profileRoute:
        return MaterialPageRoute(
            builder: (_) => const ProfilePage(),
            settings: settings
        );


      default:
        return MaterialPageRoute(
            builder: (_) => UnExpectedErrorPage(),
            settings: settings
        );
    }
  }
}

//todo:
class UnExpectedErrorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UnExpected Error'),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

