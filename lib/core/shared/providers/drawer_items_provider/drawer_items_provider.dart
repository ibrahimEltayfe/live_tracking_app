import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/core/constants/app_routes.dart';
import 'package:flutter_projects/core/shared/enums/user_type.dart';
import 'package:flutter_projects/core/shared/models/drawer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_icons.dart';

final drawerItemsProvider = Provider.autoDispose.family<List<DrawerModel>,UserType>((ref,userType) {
  if(userType == UserType.unDefined) {
    return [];
  }

    return [
      DrawerModel(
        title: 'Home',
        routeName: AppRoutes.homeRoute,
        faIcon: AppIcons.homeFa,
        isSelected: false,
        onTap: (context,routeName) {
          if(routeName != AppRoutes.homeRoute){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute,(route) => route.settings.name == AppRoutes.homeRoute,);
          }
        },
      ),

      DrawerModel(
          title: 'Profile',
          faIcon: AppIcons.profileFa,
          routeName: AppRoutes.profileRoute,
          isSelected: false,
          onTap: (context,routeName) {
            if(routeName != AppRoutes.profileRoute){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.profileRoute,(route) => route.settings.name == AppRoutes.homeRoute,);
            }
          },
      ),

      if(userType == UserType.tracker)
        DrawerModel(
            title: 'Buy a unit',
            routeName: AppRoutes.buyUnitRoute,
            faIcon: AppIcons.buyUnit,
            isSelected: false,
            onTap: (context,routeName) {
              if(routeName != AppRoutes.buyUnitRoute){
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.buyUnitRoute,(route) => route.settings.name == AppRoutes.homeRoute,);
              }
            },
        ),

      DrawerModel(
          title: 'FAQs',
          routeName: AppRoutes.faqsRoute,
          faIcon: AppIcons.faqFa,
          isSelected: false,
          onTap: (context,routeName) {
            if(routeName != AppRoutes.faqsRoute){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.faqsRoute,(route) => route.settings.name == AppRoutes.homeRoute,);
            }
          },
      ),

      DrawerModel(
          title: 'About',
          faIcon: AppIcons.aboutFa,
          routeName: AppRoutes.aboutRoute,
          isSelected: false,
          onTap: (context,routeName) {
            if(routeName != AppRoutes.aboutRoute){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.aboutRoute,(route) => route.settings.name == AppRoutes.homeRoute,);
            }
          },
      ),

    ];

});
