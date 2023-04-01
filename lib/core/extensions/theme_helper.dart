import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

extension ThemeHelper on BuildContext{
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension CustomThemeColors on ThemeData{

  Color get primaryColor{
    return AppColors.black;
  }


  Color get whiteColor{
    return AppColors.white;
  }

  Color get red{
    return AppColors.red;
  }

  Color get green{
    return AppColors.green;
  }

  Color get backgroundColor{
    return AppColors.backgroundColor;
  }

  Color get mud{
    return AppColors.mudColor;
  }

  Color get darkGrey{
    return AppColors.darkGrey;
  }

  Color get greyColor{
    return AppColors.grey;
  }

  Color get lightGrey{
    return AppColors.lightGrey;
  }

}