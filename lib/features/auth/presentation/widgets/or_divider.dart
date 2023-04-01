import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/mediaquery_size.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.86.sw,
      child: Row(
        children: [
          Expanded(child: Divider(color: context.theme.darkGrey,)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
            child:Text(
              context.localization.or,
              style: context.textTheme.titleSmall,
            ),
          ),
          Expanded(child: Divider(color: context.theme.darkGrey,)),

        ],
      ),
    );
  }
}
