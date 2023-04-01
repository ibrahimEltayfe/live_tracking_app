import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_fonts.dart';

class AppThemes {
  static ThemeData lightTheme(BuildContext context, Locale locale) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.black,
      shadowColor: AppColors.lightGrey,
      /* -the rest of colors are in theme extension- */

      fontFamily: locale.languageCode == 'ar' ? AppFonts.dubaiFont : AppFonts.senFont,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 35.sp
        ),

        displayMedium: TextStyle(
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
            fontSize: 30.sp
        ),
        /* - bold text styles - */
        titleLarge: TextStyle(
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
            fontSize: 26.sp
        ),
        titleMedium: TextStyle(
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),

        /* - for text field labels - */
        labelMedium: TextStyle(
          color: AppColors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),

        /* - for buttons - */
        headlineSmall: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),

        bodySmall: TextStyle(
          color: AppColors.grey,
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),

        bodyMedium: TextStyle(
          color: AppColors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
