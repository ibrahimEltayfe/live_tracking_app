import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_icons.dart';

class BackButtonBox extends StatelessWidget {
  const BackButtonBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        width: 53.w,
        height: 51.h,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          boxShadow:[
            BoxShadow(
              color: Color(0x2b000000),
              blurRadius: 11.r,
              offset: Offset(2.w, 4.h),
            ),
          ],
          color: context.theme.whiteColor,
        ),
        child: const FittedBox(
          child: FaIcon(AppIcons.leftArrowFa),
        ),
      ),
    );
  }
}
