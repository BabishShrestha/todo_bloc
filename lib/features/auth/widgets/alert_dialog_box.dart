import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';

import '../../../core/utils/constants.dart';

showAlertDialog({
  required String message,
  required BuildContext context,
  String? buttonText,
}) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: ReusableText(
              text: message,
              style: appStyle(16, AppConst.kLight, FontWeight.w600),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  buttonText ?? 'OK',
                  style: appStyle(16, AppConst.kLight, FontWeight.w600),
                ),
              )
            ],
          ));
}
