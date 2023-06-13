import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/custom_otn_btn.dart';
import 'package:todo_riverpod/core/widgets/spacer.dart';

import '../../auth/pages/login_page.dart';

class Ending extends StatelessWidget {
  const Ending({super.key});

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
            const HeightSpacer(spaceHeight: 50),
            CustomOutlineButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                width: AppConst.kWidth * 0.9,
                height: AppConst.kHeight * 0.06,
                borderColor: AppConst.kLight,
                text: "Login with Phone number")
          ]),
    );
  }
}
