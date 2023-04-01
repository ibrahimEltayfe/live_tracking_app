import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool isObscure;
  final double borderRadius;
  final TextAlign textAlign;
  final bool isReadOnly;

  const InputTextField({
    Key? key,
    this.width,
    this.height,
    this.isObscure = false,
    this.hint,
    this.validator,
    required this.controller,
    required this.textInputAction,
    this.keyboardType,
    this.borderRadius = 0,
    this.textAlign = TextAlign.start,
    this.isReadOnly = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width ?? 320.w,
      //height: height,
      child: TextFormField(
        readOnly: isReadOnly,
        validator: validator,
        controller: controller,
        style: context.textTheme.titleMedium,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: context.theme.primaryColor,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: isObscure,
        textAlign: textAlign,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: context.textTheme.labelMedium,
          alignLabelWithHint: true,
          filled: false,

          errorStyle: context.textTheme.titleSmall!.copyWith(
            fontSize: 14.sp,
            color: context.theme.red
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: context.theme.primaryColor)
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: context.theme.primaryColor)
          ),

        ),
      ),
    );
  }
}
