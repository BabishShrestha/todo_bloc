import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function()? onPressed;

  final double height;

  final double width;
  final Color? bgColor;

  final Color borderColor;
  final Color? textColor;

  final String text;

  const CustomOutlineButton(
      {super.key,
      this.onPressed,
      required this.height,
      required this.width,
      this.bgColor,
      required this.borderColor,
      required this.text,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      ),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appStyle(14, textColor ?? borderColor, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
