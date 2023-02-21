import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MySnackBar extends Flushbar {
  MySnackBar({Key? key}) : super(key: key);

  static Flushbar error(
      {required String message,
      required Color color,
      required BuildContext context}) {
    return Flushbar(
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: color,
      duration: const Duration(milliseconds: 3000),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
              ),
        ),
      ),
    )..show(context);
  }
}
