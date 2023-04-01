import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:flutter_projects/features/auth/presentation/manager/social_login_provider/social_login_provider.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../reusable_components/toasts/error_toast.dart';

final radioButtonProvider = StateProvider.autoDispose<UserType>((ref) {
  return UserType.tracker;
});


class SocialRegisterPage extends ConsumerWidget {
  const SocialRegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35.h,),
                Text(
                  "Seems like you do not have a registered google account.",
                   style: context.textTheme.titleLarge,
                ),

                SizedBox(height: 30.h,),
                Text(
                  "Please select your account type to continue to register.",
                  style: context.textTheme.titleMedium,
                ),

                SizedBox(height: 15.h,),
                Consumer(
                  builder: (context, ref, child) {
                    final radioButtonValue = ref.watch(radioButtonProvider);
                    return Column(
                      children: [
                        ListTile(
                          title: const Text('Tracker'),
                          leading: Radio<UserType>(
                            value: UserType.tracker,
                            groupValue: radioButtonValue,
                            onChanged: (UserType? value) {
                              ref.read(radioButtonProvider.notifier).state = value!;
                            },
                            activeColor: context.theme.darkGrey,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 2.h
                          ),
                          horizontalTitleGap: 5.w,

                        ),
                        ListTile(
                          title: const Text('Client'),
                          leading: Radio<UserType>(
                            value: UserType.client,
                            groupValue: radioButtonValue,
                            onChanged: (UserType? value) {
                              ref.read(radioButtonProvider.notifier).state = value!;
                            },
                            activeColor: context.theme.darkGrey,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 2.h
                          ),
                          horizontalTitleGap: 5.w,
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 10.h,),

                Consumer(
                  builder: (context, ref, child) {
                    final socialLoginRef = ref.watch(socialLoginProvider.notifier);
                    final socialLoginState = ref.watch(socialLoginProvider);

                    ref.listen(socialLoginProvider, (previous, current) {
                      if(current is SocialLoginError){
                        showErrorToast(current.message);
                      }else if(current is SocialLoginSuccess){
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
                      }
                    });

                    return  Center(
                      child: ActionButton(
                        width: 350.w,
                        title: 'Register',
                        isLoading: socialLoginState is SocialLoginLoading,
                        onTap: () async{
                          await socialLoginRef.registerWithGoogle(ref.read(radioButtonProvider));
                        },

                      ),
                    );
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
