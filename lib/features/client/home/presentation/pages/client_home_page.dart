import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/features/client/home/presentation/manager/location_updater_provider/location_updater_provider.dart';
import 'package:flutter_projects/features/client/home/presentation/widgets/client_session_widget.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../reusable_components/drawer/drawer.dart';
import '../../../../reusable_components/drawer/drawer_icon.dart';
import '../manager/client_tracking_sessions_provider/client_tracking_sessions_provider.dart';
import '../manager/trackers_data_provider/trackers_data_provider.dart';
import '../widgets/client_add_session_bottom_sheet.dart';

class ClientHomePage extends ConsumerStatefulWidget {
  const ClientHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends ConsumerState<ClientHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(8.r),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              const DrawerIcon(),

              SizedBox(height: 22.h,),

              Text(context.localization.trackingSessions,style: context.textTheme.titleLarge,),

              SizedBox(height: 14.h,),

              const _BuildTrackingSessions(),

              const _BuildAddSessionButton()

            ],
          ),
        ),
      ),
    );
  }
}
class _BuildAddSessionButton extends ConsumerWidget {
  const _BuildAddSessionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Center(
        child: ActionButton(
          onTap: (){
            showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(
                maxHeight: 400.h,
                minHeight: 300.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              useSafeArea: true,
              isScrollControlled: true,
              builder: (context) => const ClientAddSessionBottomSheet(),

            );
          },
          title: context.localization.addSession,
          width: 360.w,
        ),
      ),
    );
  }
}

class _BuildTrackingSessions extends StatelessWidget {
  const _BuildTrackingSessions({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final clientTrackingSessionsState = ref.watch(clientTrackingSessionsProvider);

          ref.listen(clientTrackingSessionsProvider, (previous, current) {
            if(current is ClientTrackingSessionsError){
              Fluttertoast.showToast(msg: current.message);
            }
          });

          if(clientTrackingSessionsState is ClientTrackingSessionsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final sessions = ref.watch(clientTrackingSessionsProvider.notifier).sessions;

          if(sessions.isEmpty){
            return Center(
              child: Text("No Sessions yet.",style: context.textTheme.titleMedium,),
            );
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, i) {
              return _BuildTrackingCard(sessions[i]);
            },
          );
        },
      ),
    );
  }
}

class _BuildTrackingCard extends ConsumerWidget {
  final TrackingSessionModel session;
  const _BuildTrackingCard(this.session,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    if(session.trackerId!.isEmpty){
      return ClientSessionWidget(
        trackerData: null,
        session: session,
      );
    }

    final trackerDataRef = ref.watch(trackerDataProvider(session.trackerId!));

    return trackerDataRef.when(
      error: (e, stackTrace) {
        log(e.toString());
        final error = e as Failure;
        log(error.message.toString());//todo:
        return const SizedBox.shrink();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data){
        final UserModel? trackerData = data as UserModel?;

        return ClientSessionWidget(
            trackerData: trackerData,
            session: session,
          );

      },
    );

  }

}



