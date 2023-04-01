import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? cornerRadius;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const ActionButton({
    this.cornerRadius,
    this.width,
    this.height,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 7.h
                )
            ),
            fixedSize: MaterialStatePropertyAll<Size>(
                Size(
                    width??320.w,
                    height??52.h
                )
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor ?? context.theme.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cornerRadius ?? 5.r),
                )
            ),
          ),
          onPressed: onTap,
          child: isLoading
           ?Lottie.asset("assets/lottie/loading.json",fit: BoxFit.contain
             )
           :FittedBox(
            child: Text(
              title,
              style:

              context.textTheme.headlineSmall!.copyWith(
                color: textColor
              ),),
          )
      ),
    );
  }
}
