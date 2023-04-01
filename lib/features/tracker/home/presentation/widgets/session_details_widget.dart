import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared/models/tracking_data_model.dart';
import '../../../../../core/shared/models/user_model.dart';

class TrackerSessionDetails extends StatelessWidget {
  final TrackingSessionModel session;
  final UserModel? clientData;
  final int? textMaxLines;
  const TrackerSessionDetails(this.session,this.clientData,{Key? key,this.textMaxLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildTextWidget(
            title:"Session name: ",
            value: session.sessionName!,
            maxLines: textMaxLines,
          ),

          SizedBox(height: 3.h,),

          _BuildTextWidget(
            title:"Session password: ",
            value: session.sessionPassword!,
            maxLines: textMaxLines,
          ),

          SizedBox(height: 3.h,),

          _BuildTextWidget(
            title:"Intervals: ",
            value: "${session.interval} seconds",
            maxLines: textMaxLines,
          ),

          SizedBox(height: 3.h,),

          _BuildTextWidget(
            title: (clientData == null)
                ? ''
                :"client: ",
            value: (clientData == null)
                ?"there is no client on this session yet."
                : clientData!.name!,
            maxLines: textMaxLines,
          ),

        ],
      ),
    );
  }
}

class _BuildTextWidget extends StatelessWidget {
  final String title;
  final String value;
  final int? maxLines;
  const _BuildTextWidget({Key? key, required this.title,required this.value, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
        maxLines: maxLines,
        overflow: (maxLines == null)?TextOverflow.visible:TextOverflow.ellipsis,
        textAlign: TextAlign.start,

        text: TextSpan(
          children:[
            TextSpan(
              text: title,
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.theme.primaryColor
              ),
            ),

            TextSpan(
              text: value,
              style: context.textTheme.bodyMedium,
            ),

          ]
        ),

      ),
    );
  }
}
