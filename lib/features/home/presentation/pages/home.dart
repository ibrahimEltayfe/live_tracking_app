import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/app_routes.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_projects/features/tracker/home/presentation/pages/tracker_home_page.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/error_handling/failures.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../../client/home/presentation/manager/client_tracking_sessions_provider/client_tracking_sessions_provider.dart';
import '../../../client/home/presentation/pages/client_home_page.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userDataState = ref.watch(userDataProvider);
    if(userDataState is UserDataLoading){

      return const _BuildLoadingWidget();

    }else if(userDataState is UserDataError){

      return _BuildErrorWidget(userDataState.failure);

    }else if(userDataState is UserDataFetched){

      final UserModel userModel = ref.watch(userDataProvider.notifier).userModel!;

      if(userModel.type == UserType.client){
        log(userModel.toString());
        return const ClientHomePage();
      }else{
        return const TrackerHomePage();
      }

    }

    return const Scaffold(body: SizedBox.shrink());
  }
}

class _BuildErrorWidget extends ConsumerWidget {
  final Failure failure;
  const _BuildErrorWidget(this.failure,{Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              failure.message,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            if(failure is NoDataFailure)
              ActionButton(
                  title: "Go To Login Page",
                  width: 200.w,
                  onTap: (){
                    //todo:
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route) => false);
                  }
              )

            else
              ...[
                ActionButton(
                    title: "try Again",
                    width: 180.w,
                    height: 45.h,
                    onTap: (){
                      final UserModel userModel = ref.watch(userDataProvider.notifier).userModel!;
                      ref.read(clientTrackingSessionsProvider.notifier).getAllSessions(userModel.id!);
                    }
                ),

                SizedBox(height: 6.h,),
                ActionButton(
                    title: "Go To Login Page",
                    width: 180.w,
                    height: 45.h,

                    onTap: (){
                      //todo:
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route) => false);
                    }
                )
              ]


          ],
        ),
      ),
    );
  }
}

class _BuildLoadingWidget extends StatelessWidget {
  const _BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: context.theme.primaryColor,),
      ),
    );
  }
}
