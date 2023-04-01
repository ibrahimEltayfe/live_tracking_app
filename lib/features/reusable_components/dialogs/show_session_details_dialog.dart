import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared/no_context_localization.dart';
import '../../tracker/home/presentation/widgets/session_details_widget.dart';

 Future showSessionDetailsDialog(TrackingSessionModel session,UserModel? clientData) async{
   await showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      log('hh');

      return AlertDialog(

        backgroundColor: context.theme.whiteColor,
        title: SelectionArea(
          child: SizedBox(
            width: 0.9.sw,
            height: 0.13.sh,
            child: SingleChildScrollView(
              child: TrackerSessionDetails(
                session,
                clientData,
                textMaxLines: null,
              ),
            ),
          ),
        ),

        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide.none
        ),
        actionsAlignment: MainAxisAlignment.center,

        actions: [
          //todo:
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Text("close",style: context.textTheme.titleMedium!.copyWith(
              color: Color(0xff0060D0)
            ),),
          )
        ],

      );
    },
  );
}