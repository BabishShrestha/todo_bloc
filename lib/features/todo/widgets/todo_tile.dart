import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';

import '../../../core/utils/constants.dart';

class TodoTile extends StatelessWidget {
  final String? title;
  final String? description;

  final Color? color;

  final String? start;
  final String? end;

  final Widget? editWidget;

  final Function()? onTapDelete;

  final Widget? switcher;

  const TodoTile({
    super.key,
    this.title,
    this.description,
    this.color,
    this.start,
    this.end,
    this.editWidget,
    this.onTapDelete,
    this.switcher,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      // child: SizedBox(
      // width: AppConst.kWidth * 0.3,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.kWidth,
            decoration: BoxDecoration(
              color: AppConst.kGreyLight,
              borderRadius: BorderRadius.circular(AppConst.kRadius),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80.h,
                  width: 5.w,
                  // padding: EdgeInsets.symmetric(
                  //   // horizontal: 10.w,
                  //   vertical: 18.h,
                  // ),
                  decoration: BoxDecoration(
                    color: color ?? AppConst.kRed,
                    borderRadius: BorderRadius.circular(AppConst.kRadius),
                  ),
                ),
                WidthSpacer(spaceWidth: 15.w),
                Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: SizedBox(
                      width: AppConst.kWidth * 0.6,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title of TODO",
                              style: appStyle(
                                  16, AppConst.kLight, FontWeight.bold),
                            ),
                            HeightSpacer(spaceHeight: 3.h),
                            ReusableText(
                              text: description ?? "Description of TODO",
                              style: appStyle(
                                  10, AppConst.kLight, FontWeight.bold),
                            ),
                            const HeightSpacer(spaceHeight: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: AppConst.kBkDark,
                                    border: Border.all(
                                      color: AppConst.kGreyDk,
                                      width: 0.3,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(AppConst.kRadius),
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: "$start - $end",
                                      style: appStyle(10, AppConst.kLight,
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                                WidthSpacer(spaceWidth: 10.w),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    WidthSpacer(spaceWidth: 20.w),
                                    GestureDetector(
                                      onTap: onTapDelete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
