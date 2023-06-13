import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';
import 'package:todo_riverpod/core/widgets/spacer.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: Image.asset(AppConst.todo),
            ),
            const HeightSpacer(spaceHeight: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText(
                  text: AppConst.onBoardingTitle,
                  style: appStyle(20, AppConst.kLight, FontWeight.w600),
                ),
                const HeightSpacer(spaceHeight: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    AppConst.onBoardingSubtitle,
                    textAlign: TextAlign.center,
                    style: appStyle(12, AppConst.kGreyLight, FontWeight.normal),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
