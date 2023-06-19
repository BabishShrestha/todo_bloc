import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/features/todo/widgets/custom_expansion_tile.dart';

import '../../../core/utils/constants.dart';

class TodoTile extends StatelessWidget {
  // final String title;
  // final String subtitle;

  const TodoTile({super.key, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth * 0.3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5.w,
            height: 50.h,
            padding: EdgeInsets.symmetric(
              // horizontal: 10.w,
              vertical: 18.h,
            ),
            decoration: BoxDecoration(
              color: AppConst.kBlueLight,
              borderRadius: BorderRadius.circular(AppConst.kRadius),
            ),
          ),
          const CustomExpansionTile(
            title: "Title of Test",
            subtitle: "Change to Completed",
            children: [],
          ),
        ],
      ),
    );

    
  }
}
