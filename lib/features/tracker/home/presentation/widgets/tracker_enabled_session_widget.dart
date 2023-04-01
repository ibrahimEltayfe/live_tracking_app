import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/app_routes.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/shared/enums/user_state.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../reusable_components/dialogs/show_session_details_dialog.dart';
import '../../../../reusable_components/shimmer_loading_effect.dart';
import '../../../../reusable_components/user_network_imagee.dart';
import '../manager/tracker_session_actions_provider/actions_waiting_list_provider.dart';
import '../manager/tracker_session_actions_provider/tracker_session_actions_provider.dart';

class TrackerEnabledSessionWidget extends ConsumerWidget {
  final UserModel? clientData;
  final TrackingSessionModel session;
  final bool isLoading;

  const TrackerEnabledSessionWidget({
    required this.clientData,
    required this.session,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if(clientData!= null){
          Navigator.pushNamed(context, AppRoutes.mapRoute,arguments: session.locationId);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Container(
            width: 326.w,
            height: 90.h,
            decoration: getSessionBoxDecoration(context),

            child: ShimmerLoadingEffect(
              startAnim: isLoading,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  if(clientData == null)
                    PositionedDirectional(
                        start: 15.w,
                        width: 300.w,
                        child: Text(
                          "there is no clients on this session for now."
                          ,style: context.textTheme.titleMedium,
                        )
                    )
                  else
                    ...[
                      _BuildClientStateVerticalBar(clientData!.state!,),

                      _BuildClientImage(clientData!.image!),

                      _BuildClientName(clientData!.name!),

                      _BuildClientState(clientData!.state!)
                    ],

                  Positioned(
                    top: 12.h,
                    right: 16.w,
                    child: _BuildMenuButton(
                      sessionModel: session,
                      clientData: clientData,
                    ),
                  )

                ],
              ),
            )

        ),
      ),
    );
  }
}

class _BuildMenuButton extends ConsumerWidget {
  final TrackingSessionModel sessionModel;
  final UserModel? clientData;
  const _BuildMenuButton({required this.sessionModel,required this.clientData,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
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
                onTap: (){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showSessionDetailsDialog(sessionModel,clientData);
                  });
                },
                child: Text(
                  "Details",
                  style: context.textTheme.titleMedium,
                ),
              ),

              PopupMenuItem(
                onTap: () async{
                  ref.read(sessionsActionsQueueProvider.notifier).state.add(sessionModel);

                  await ref.read(trackerSessionActionsProvider.notifier).disableSession(sessionModel.id!);
                },
                child: Text(
                  "Disable Session",
                  style: context.textTheme.titleMedium,
                ),
              ),

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
    );
  }
}

class _BuildClientState extends StatelessWidget {
  final UserState clientState;
  const _BuildClientState(this.clientState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.h,
      right: 16.w,
      child: Row(
        children: [
          SizedBox(
            width: 9.w,
            height: 9.h,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ColoredBox(
                color:
                (clientState == UserState.connected)
                    ? context.theme.green
                    : context.theme.mud,
              ),
            ),
          ),

          const SizedBox(width: 6,),

          Text(clientState.getStateName, style: context.textTheme.titleSmall,)

        ],
      ),
    );
  }
}

class _BuildClientName extends StatelessWidget {
  final String trackerName;
  const _BuildClientName(this.trackerName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 33.h,
      left: 86.w,
      width: 210.w,
      height: 20.h,
      child: Text(
        trackerName,
        style: context.textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _BuildClientStateVerticalBar extends StatelessWidget {
  final UserState trackerState;
  const _BuildClientStateVerticalBar( this.trackerState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15.h,
      left: 15.w,
      width: 10.w,
      height: 53.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ColoredBox(
          color: (trackerState == UserState.connected)
              ? context.theme.green
              : context.theme.mud,
        ),
      ),
    );
  }
}

class _BuildClientImage extends StatelessWidget {
  final String imageUrl;
  const _BuildClientImage(this.imageUrl,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 35.w,
      width: 44.r,
      height: 44.r,
      child: ClipOval(
        child: imageUrl.isEmpty
         ? ColoredBox(color: context.theme.lightGrey,)
         : UserNetworkImage(imageUrl),
      )

    );
  }
}
