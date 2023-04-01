import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../reusable_components/toasts/error_toast.dart';
import '../manager/social_login_provider/social_login_provider.dart';


class SocialButtons extends ConsumerWidget {
  final Function() googleOnTap;
  const SocialButtons({required this.googleOnTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(socialLoginProvider, (previous, current) {
      if(current is SocialLoginError){
        showErrorToast(current.message);
      }else if(current is SocialLoginSuccess){
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
      }else if(current is SocialLoginUserNotExist){
        Navigator.pushNamed(context, AppRoutes.socialRegisterRoute);
      }
    });

    if(ref.watch(socialLoginProvider) is SocialLoginLoading){
      return Lottie.asset(
        "assets/lottie/loading_black.json",
        width: 55.w,
        height: 55.h,
        fit: BoxFit.contain,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BuildSocialCircle(
          onTap:googleOnTap,
          icon:AppIcons.googleFa,
        ),

      ],
    );
  }
}

class _BuildSocialCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _BuildSocialCircle({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        width: 45.w,
        height: 45.h,
        padding: EdgeInsets.all(9.r),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.theme.primaryColor)
        ),

        child: FittedBox(
          child: FaIcon(icon),
        ),
      ),
    );
  }
}
