import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DrawerModel extends Equatable{
  String title;
  IconData faIcon;
  bool isSelected;
  String routeName;
  void Function(BuildContext,String) onTap;

  DrawerModel({required this.title,required this.faIcon,required this.isSelected,required this.onTap,required this.routeName});

  @override
  List<Object?> get props => [
    isSelected,
  ];
}