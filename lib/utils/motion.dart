import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sizer/sizer.dart';

class Utils {
  alertNormal(String text, String title, BuildContext context) {
    MotionToast(
      width: 90.0.w,
      height: 15.0.h,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0.sp),
      ),
      description: Text(
        text,
        style: TextStyle(fontSize: 13.0.sp, color: Colors.black),
      ),
      primaryColor: Colors.red,
    ).show(context);
  }
}
