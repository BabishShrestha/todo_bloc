import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/utils/extensions.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/spacer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableText(
            text: 'Todo ',
            style: appStyle(20, AppConst.kBlueLight, FontWeight.bold),
          ),
          const HeightSpacer(spaceHeight: 50),
          50.horizontalSpace,
          const WidthSpacer(
            spaceWidth: 50,
          ),
          ReusableText(
            text: 'Todo ',
            style: appStyle(20, AppConst.kBlueLight, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
