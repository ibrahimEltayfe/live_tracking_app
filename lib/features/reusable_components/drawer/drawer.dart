import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/models/drawer_model.dart';
import 'package:flutter_projects/core/shared/models/user_model.dart';
import 'package:flutter_projects/core/shared/providers/drawer_items_provider/drawer_items_provider.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../user_network_imagee.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userModel = ref.watch(userDataProvider.notifier).userModel!;
    final drawerItemsRef = ref.watch(drawerItemsProvider(userModel.type!));

    return SafeArea(
      child: Drawer(
        width: 0.75.sw,
        child: Column(
          children: [
            SizedBox(height: 14.h,),
            _BuildUserDetails(userModel),

            SizedBox(height: 5.h,),
            Expanded(
              child: ListView.builder(
                itemCount: drawerItemsRef.length,
                itemBuilder: (context, index) {
                  if(drawerItemsRef.length - 2 == index){
                    return Column(
                      children: [
                        SizedBox(height: 2.h,),

                        Divider(
                         thickness: 1.h,
                         color: context.theme.lightGrey,
                        ),

                        SizedBox(height: 2.h,),
                        _BuildDrawerItem(drawerModel: drawerItemsRef[index])
                      ],
                    );
                  }

                  return _BuildDrawerItem(drawerModel: drawerItemsRef[index],);

                },
              ),
            )
          ],

        ),
      ),
    );
  }
}

class _BuildUserDetails extends StatelessWidget {
  final UserModel userModel;
  const _BuildUserDetails(this.userModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        height: 0.18.sh,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 55.r,
                width: 55.r,
                child: UserNetworkImage(userModel.image!),
              ),
            ),

            SizedBox(height: 8.h,),

            Flexible(
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                text: TextSpan(
                  children: [
                    TextSpan(
                      text: userModel.name!,
                      style: context.textTheme.titleMedium,
                    ),

                    TextSpan(
                      text: " (${userModel.type!.name})",
                      style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal),
                    )
                  ]
                ),
              ),
            ),

            SizedBox(height: 3.h,),

            Flexible(
               child: Text(
                 userModel.email!,
                 style: context.textTheme.bodySmall,
                 overflow: TextOverflow.ellipsis,
               ))
          ],
        ),
      ),
    );
  }
}

class _BuildDrawerItem extends ConsumerWidget {
  final DrawerModel drawerModel;
  const _BuildDrawerItem({Key? key,required this.drawerModel}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final routeName = ModalRoute.of(context)!.settings.name;

    if(routeName == drawerModel.routeName){
      drawerModel.isSelected = true;
    }else{
      drawerModel.isSelected = false;
    }

    return GestureDetector(
      onTap: (){
        drawerModel.onTap(context, routeName ?? '');
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: drawerModel.isSelected?context.theme.lightGrey:Colors.transparent
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: FaIcon(drawerModel.faIcon,color: context.theme.darkGrey,size: 20.r,)
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    drawerModel.title,
                    style: context.textTheme.titleMedium,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

