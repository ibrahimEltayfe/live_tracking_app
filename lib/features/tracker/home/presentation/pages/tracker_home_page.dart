import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/session_state_enum.dart';
import 'package:flutter_projects/features/client/home/presentation/manager/location_updater_provider/location_updater_provider.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/error_handling/failures.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../reusable_components/drawer/drawer.dart';
import '../../../../reusable_components/drawer/drawer_icon.dart';
import '../../../../reusable_components/toasts/error_toast.dart';
import '../manager/client_data_provider/client_data_provider.dart';
import '../manager/tracker_session_actions_provider/actions_waiting_list_provider.dart';
import '../manager/tracker_session_actions_provider/tracker_session_actions_provider.dart';
import '../manager/tracker_tracking_sessions_provider/tracker_tracking_sessions_provider.dart';
import '../widgets/tracker_add_session_bottom_sheet.dart';
import '../widgets/tracker_disabled_session_widget.dart';
import '../widgets/tracker_enabled_session_widget.dart';

class TrackerHomePage extends ConsumerStatefulWidget {
  const TrackerHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrackerHomePageState();
}

class _TrackerHomePageState extends ConsumerState<TrackerHomePage> {
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
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(
                maxHeight: 450.h,
                minHeight: 400.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              useSafeArea: true,
              isScrollControlled: true,
              builder: (context) => const TrackerAddSessionBottomSheet(),

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
          final trackerTrackingSessionsState = ref.watch(trackerTrackingSessionsProvider);

          ref.listen(trackerTrackingSessionsProvider, (previous, current) {
            if(current is TrackerTrackingSessionsError){
              Fluttertoast.showToast(msg: current.message);
            }
          });

          if(trackerTrackingSessionsState is TrackerTrackingSessionsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final sessions = ref.watch(trackerTrackingSessionsProvider.notifier).sessions;

          if(sessions.isEmpty){
            return Center(
              child: Text("No Active Sessions.",style: context.textTheme.titleMedium,),
            );
          }

          return RefreshIndicator(
            color: context.theme.primaryColor,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            edgeOffset: -20,
            onRefresh: () async{
              await ref.read(trackerTrackingSessionsProvider.notifier).getAllSessions(
                  ref.read(userDataProvider.notifier).userModel!.id!
              );
            },
            child: ListView.builder(
              itemCount: sessions.length,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()
              ),
              itemBuilder: (context, i) {
                return _BuildTrackingCard(sessions[i]);
              },
            ),
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
    final sessionModels = ref.watch(sessionsActionsQueueProvider.notifier).state;

    final trackerSessionControlState = ref.watch(trackerSessionActionsProvider.select((value){
      //listen only for selected session card
      if(sessionModels.contains(session)){
        return value;
      }
    }));

    bool startLoadingShimmer = (trackerSessionControlState is TrackerSessionActionsLoading)
        || (sessionModels.contains(session));

    ref.listen(trackerSessionActionsProvider.select((value){
      if(sessionModels.contains(session)){
        return value;
      }
    }), (_, current) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if(current is TrackerSessionDisabled){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ref.read(trackerTrackingSessionsProvider.notifier).disableSessionInList(current.sessionId);
          });

        }else if(current is TrackerSessionEnabled){
          ref.read(trackerTrackingSessionsProvider.notifier).enableSessionInList(current.sessionId);

        }else if(current is TrackerSessionDeleted){
          ref.read(trackerTrackingSessionsProvider.notifier).deleteFromSessionsList(current.sessionId);

        }else if(current is TrackerSessionActionsError){
          showErrorToast(current.message);
        }

        log(current.toString());
        if(current is! TrackerSessionActionsInitial && current is! TrackerSessionActionsLoading){
          ref.read(sessionsActionsQueueProvider.notifier).state.remove(session);
        }

      });
    });

    final clientDataRef = ref.watch(clientDataProvider(session.clientId!));

    return clientDataRef.when(
      error: (e, stackTrace) {
        log(e.toString());
        final error = e as Failure;
        log(error.message.toString());//todo:
        return const SizedBox.shrink();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data){
        final UserModel? clientData = data as UserModel?;

        if(session.state == SessionState.active){
          return TrackerEnabledSessionWidget(
            clientData: clientData,
            session: session,
            isLoading: startLoadingShimmer,
          );
        }else{
          return TrackerDisabledSessionWidget(
              clientData: clientData,
              session: session,
              isLoading: startLoadingShimmer
          );
        }
      },
    );
  }
}


