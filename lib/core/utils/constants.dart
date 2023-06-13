import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConst {

  AppConst._();
  static const Color kBkDark = Color(0xff2a2b2e);
  static const Color kLight = Color(0xffFFFFFF);
  static const Color kRed = Color(0xffd80000);
  static const Color kBlueLight = Color(0xff027eb5);
  static const Color kGreyDk = Color(0xff707070);
  static const Color kGreyLight = Color(0xff667781);
  static const Color kGreen = Color(0xff20a31E);
  static const Color kYellow = Color(0xfff9f900);
  static const Color kBkLight = Color(0x58797777);
  static const Color kGreyBk = Color(0xff202c33);

  static double kWidth = 375.w;
  static double kHeight = 812.h;
  static double kRadius = 12.r;

  /// Image path
  static const String todo = "assets/images/todo.png";
  static const String notification = "assets/images/notification.png";
  static const String bell = "assets/images/bell.png";


  ///Onboarding Text
  static const String onBoardingTitle = '"ToDo with Riverpod"';
  static const String onBoardingSubtitle = "Welcome to a simple TODO app built with Riverpod. Lets finish those tasks, shall we?";

}
