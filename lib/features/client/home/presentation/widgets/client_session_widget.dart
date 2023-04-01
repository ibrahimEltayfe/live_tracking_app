import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/session_state_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/shared/enums/user_state.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../reusable_components/user_network_imagee.dart';

class ClientSessionWidget extends ConsumerWidget {
  final UserModel? trackerData;
  final TrackingSessionModel session;

  const ClientSessionWidget({
    required this.trackerData,
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
            height: 90.h,
            decoration: getSessionBoxDecoration(context),

            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                if(trackerData == null)
                  PositionedDirectional(
                      start: 15.w,
                      width: 300.w,
                      child: Text(
                        "there is no tracker on this session yet."
                        ,style: context.textTheme.titleMedium,
                      )
                  )
                else
                  ...[
                    _BuildTrackerImage(trackerData!.image!),

                    _BuildTrackerName(trackerData!.name!),

                    _BuildSessionState(session.state!)
                  ],

              ],
            )

        ),
      ),
    );
  }
}

class _BuildSessionState extends StatelessWidget {
  final SessionState sessionState;
  const _BuildSessionState(this.sessionState, {Key? key}) : super(key: key);

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
                (sessionState == SessionState.active)
                    ? context.theme.green
                    : context.theme.mud,
              ),
            ),
          ),

          const SizedBox(width: 6,),

          Text(sessionState.getString, style: context.textTheme.titleSmall,)

        ],
      ),
    );
  }
}

class _BuildTrackerName extends StatelessWidget {
  final String trackerName;
  const _BuildTrackerName(this.trackerName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 33.h,
      left: 70.w,
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

class _BuildTrackerImage extends StatelessWidget {
  final String imageUrl;
  const _BuildTrackerImage(this.imageUrl,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 18.w,
      width: 45.r,
      height: 45.r,
      child: UserNetworkImage(imageUrl)
    );
  }
}
