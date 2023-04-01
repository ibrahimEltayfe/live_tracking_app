import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration getSessionBoxDecoration(BuildContext context){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(24.r),
    boxShadow: [
      BoxShadow(
          color: context.theme.shadowColor,
          blurRadius: 22.r,
          offset: Offset(0, 4.h),
          spreadRadius: 1.r
      ),
    ],
    color: context.theme.whiteColor,
  );
}