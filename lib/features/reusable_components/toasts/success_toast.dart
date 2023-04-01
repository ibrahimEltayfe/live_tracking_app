import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/core/constants/app_colors.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSuccessToast(String message){
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.green,
      textColor: AppColors.white
  );
}