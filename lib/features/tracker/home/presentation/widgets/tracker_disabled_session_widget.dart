import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/app_styles.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import 'package:flutter_projects/features/tracker/home/presentation/widgets/session_details_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../reusable_components/shimmer_loading_effect.dart';
import '../manager/tracker_session_actions_provider/actions_waiting_list_provider.dart';
import '../manager/tracker_session_actions_provider/tracker_session_actions_provider.dart';

class TrackerDisabledSessionWidget extends ConsumerWidget {
  final UserModel? clientData;
  final TrackingSessionModel session;
  final bool isLoading;

  const TrackerDisabledSessionWidget( {
    required this.isLoading,
    required this.clientData,
    required this.session,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Container(
          width: 326.w,
          height: 100.h,
          decoration: getSessionBoxDecoration(context),

          child: ShimmerLoadingEffect(
            startAnim: isLoading,
            child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.w, end: 87.w, top: 12.h, bottom: 12.h,),
                    child: TrackerSessionDetails(session,clientData)
                  ),

                  _BuildMenuButton(
                    sessionModel: session,
                  ),

                  _BuildEnableButton(
                    sessionModel: session,
                  )

                ],
              ),
          ),
        ),
      ),
    );
  }
}

class _BuildEnableButton extends ConsumerWidget {
  final TrackingSessionModel sessionModel;
  const _BuildEnableButton({
    required this.sessionModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PositionedDirectional(
      bottom: 14.h,
      end: 13.w,
      width: 70.w,
      height: 15.h,
      child: GestureDetector(
        onTap: () async{

            ref.read(sessionsActionsQueueProvider.notifier).state.add(sessionModel);
            await ref.read(trackerSessionActionsProvider.notifier).enableSession(sessionModel.id!);

        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Text(
                  "Enable",
                  style: context.textTheme.titleSmall,
                ),
              ),
            ),

            SizedBox(width: 2.w,),

            Expanded(
              child: FittedBox(
                child: FaIcon(
                  AppIcons.playFa,
                  color: context.theme.green,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class _BuildMenuButton extends ConsumerWidget {
  final TrackingSessionModel sessionModel;
  const _BuildMenuButton({required this.sessionModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return PositionedDirectional(
      top: 12.h,
      end: 16.w,
      child: GestureDetector(
        onTapDown: (details) async{
          final offset = details.globalPosition;
          showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy,
                1.sw - offset.dx,
                1.sh - offset.dy,
              ),
              elevation: 3,
              items: [
                PopupMenuItem(
                  onTap: () async{
                    ref.read(sessionsActionsQueueProvider.notifier).state.add(sessionModel);

                    await ref.read(trackerSessionActionsProvider.notifier).deleteSession(
                        sessionModel: sessionModel,
                        locationId: sessionModel.locationId!
                    );

                  },
                  child: Text(
                    "Delete Session",
                    style: context.textTheme.titleMedium!.copyWith(
                        color: context.theme.red
                    ),
                  ),
                ),

              ]
          );

        },
        child: FaIcon(
          AppIcons.ellipseFa,
          size: 22.r,
        ),
      ),
    );
  }
}


