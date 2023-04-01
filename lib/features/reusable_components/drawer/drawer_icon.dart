import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';

import '../../../../../core/constants/app_icons.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: SizedBox(
        width: 25,
        height: 20,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          onTap: (){
            Scaffold.of(context).openDrawer();
          },

          child: Icon(
            AppIcons.list,
            size: 14,
            color: context.theme.greyColor,
          ),
        ),
      ),
    );
  }
}
