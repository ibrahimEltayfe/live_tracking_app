import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/enums/user_type.dart';
import '../manager/user_type_provider/user_type_provider.dart';

class UserTypeSwitcher extends StatelessWidget {
  const UserTypeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 320.w,
      height: 44.h,
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.greyColor, width: 1.r, ),
      ),

      child: LayoutBuilder(
          builder: (_,size) {
            final width = size.maxWidth;
            final height= size.maxHeight;

            return Consumer(
                builder: (context, ref, child) {
                  final userTypeRef = ref.watch(userTypeProvider);
                  final isTrackerSelected = userTypeRef == UserType.tracker;

                  return Stack(
                    children: [
                      AnimatedPositionedDirectional(
                        duration: const Duration(milliseconds: 300),
                        width: width * 0.5,
                        height: height,
                        start: isTrackerSelected ? 0 : width * 0.5,
                        curve: Curves.decelerate,

                        child: ColoredBox(
                          color: context.theme.primaryColor,
                        ),
                      ),


                      PositionedDirectional(
                        start: 0,
                        child: _BuildSwitchButton(
                          width: width * 0.5,
                          height: height,
                          text: UserType.tracker.getString,
                          isSelected: userTypeRef == UserType.tracker,
                          onTap: (){
                            ref.read(userTypeProvider.notifier).state = UserType.tracker;
                          },
                        ),
                      ),

                      PositionedDirectional(
                        end: 0,
                        child: _BuildSwitchButton(
                          width: width * 0.5,
                          height: height,
                          text: UserType.client.getString,
                          isSelected: userTypeRef == UserType.client,
                          onTap: (){
                            ref.read(userTypeProvider.notifier).state = UserType.client;
                          },
                        ),
                      ),

                    ],
                  );
                }
            );
          }
      ),
    );
  }
}

class _BuildSwitchButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;
  final double width;
  final double height;
  const _BuildSwitchButton({Key? key, required this.text, required this.isSelected, required this.onTap, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Center(
        child: SizedBox(
          width: width,
          height:height,

          child: Center(
            child: SizedBox(
              width: width*0.51,
              height:height*0.51,
              child: FittedBox(
                child: Text(
                  text,
                  style: context.textTheme.titleMedium!.copyWith(
                      color: isSelected ? context.theme.whiteColor : context.theme.greyColor
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
