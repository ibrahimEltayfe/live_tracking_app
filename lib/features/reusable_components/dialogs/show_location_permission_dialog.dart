import 'package:flutter/material.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/no_context_localization.dart';
import 'package:flutter_projects/core/utils/geo_service.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/error_handling/geo_action_type.dart';

showLocationPermissionDialog({
  required GeoActionType actionType,
  required Function action
}){
  return showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        backgroundColor: context.theme.whiteColor,
        icon: Icon(Icons.location_off_outlined,size: 32.r,),
        title: Text(
          actionType.getErrorMessage,
          style: context.textTheme.titleMedium,
        ),
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide.none
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ActionButton(
            onTap: (){
              action();
              Navigator.pop(context);
            },
            title: actionType.getActionMessage,
            width: 155.w,
            height: 44.h,
          ),

        ],
      );
    },
  );
}