import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/widgets/spacer.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/app_style.dart';
import '../../../core/widgets/reusable_text.dart';

class ButtonTitle extends StatelessWidget {
  const ButtonTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leadingColor,
  });

  final String title;
  final String subtitle;
  final Color leadingColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.kWidth,
      // height: AppConst.kHeight * 0.3,

      padding: const EdgeInsets.all(8),
      // height: 50.h,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                  color: AppConst.kBlueLight,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConst.kRadius),
                  ),
                ),
              );
            },
          ),
          const WidthSpacer(spaceWidth: 10),

          //Title and subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: title,
                style: appStyle(20, AppConst.kLight, FontWeight.bold),
              ),
              const HeightSpacer(spaceHeight: 4),
              ReusableText(
                text: subtitle,
                style: appStyle(12, AppConst.kLight, FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
