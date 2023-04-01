import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/app_routes.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:flutter_projects/features/client/home/presentation/manager/location_updater_provider/location_updater_provider.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_projects/features/profile/presentation/manager/profile_user_provider.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_projects/features/reusable_components/drawer/drawer.dart';
import 'package:flutter_projects/features/reusable_components/toasts/error_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../reusable_components/drawer/drawer_icon.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 12.h),

              const DrawerIcon(),

              SizedBox(height: 22.h,),

              Consumer(
                builder: (context, ref, child) {
                  final profileUserState = ref.watch(profileUserProvider);

                  ref.listen(profileUserProvider, (previous, current) {
                    log(current.toString());

                    if(current is ProfileUserError){
                      showErrorToast(current.message);
                    }else if(current is ProfileUserSignedOut){
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route) => false);
                    }
                  });

                  return ActionButton(
                      title: 'Sign out',
                      isLoading: profileUserState is ProfileUserLoading,
                      backgroundColor: context.theme.whiteColor,
                      textColor: context.theme.primaryColor,
                      onTap: () async{
                        await ref.read(profileUserProvider.notifier).signOut();
                      }
                  );
                },
              )

            ],
          ),
        ),
      ),

    );
  }
}
