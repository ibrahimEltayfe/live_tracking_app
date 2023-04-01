import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/mediaquery_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleBackToExit extends StatelessWidget {
  final Widget child;
  DoubleBackToExit({Key? key, required this.child}) : super(key: key);

  DateTime? lastPressed;
  bool firstSwipe = false;

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          children: [
            child,

            Positioned(
              left: 0,
              top: 0,
              height: 1.sh,
              width: 0.09.sw,
              child: GestureDetector(
                onHorizontalDragEnd:(details){
                  if(firstSwipe){
                    doubleBack(context);
                    firstSwipe = false;
                  }
                },
                onHorizontalDragUpdate: (details){
                  if(details.delta.dx > 1){
                    firstSwipe = true;
                  }
                },
              ),
            ),

            Positioned(
              right: 0,
              top: 0,
              height: 1.sh,
              width: 0.09.sw,
              child: GestureDetector(
                onHorizontalDragEnd:(details){
                  if(firstSwipe){
                    doubleBack(context);
                    firstSwipe = false;
                  }
                },
                onHorizontalDragUpdate: (details){
                  if(details.delta.dx < -1){
                    firstSwipe = true;
                  }
                },
              ),
            ),

          ],
        ),
      );

    }else{
      return WillPopScope(
        onWillPop: () => doubleBack(context),
        child: child,
      );
    }
  }

  doubleBack(BuildContext context){
    final now = DateTime.now();
    final maxDuration = Duration(seconds: 2);
    final isWarning = lastPressed == null ||
        now.difference(lastPressed!) > maxDuration;

    if (isWarning) {
      lastPressed = DateTime.now();

      final snackBar = SnackBar(
        content: Text('Swipe Again To Close The App'),
        duration: maxDuration,
      );

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      lastPressed = null;
      log("exit");
      // exit(0);
    }
  }
}


