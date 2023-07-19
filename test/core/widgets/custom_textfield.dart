import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;

  final TextInputType? keyboardType;

  final String? hintText;

  final TextStyle? hintStyle;

  final TextEditingController? controller;

  final bool obscureText;

  // final validator;

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final TextStyle? style;

  final Function(String)? onChanged;

  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.keyboardType,
      this.hintText,
      this.hintStyle,
      this.controller,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.style,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.kWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
        color: AppConst.kLight,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged: onChanged,
        style: style ?? appStyle(14, AppConst.kBkDark, FontWeight.w700),
        obscureText: obscureText,
        enabled: true,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConst.kBkDark,
          hintStyle: hintStyle,
          labelText: labelText,
          hintText: hintText,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.kRed, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.kRed, width: 0.5),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.kGreyDk, width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.kBkDark, width: 0.5),
          ),
        ),
      ),
    );
  }
}
