import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';

class NotificationPage extends StatelessWidget {
  final String payload;
  const NotificationPage({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final String title = payload.split('|')[0];
    final String content = payload.split('|')[1];

    final String date = payload.split('|')[2];
    final String startTime = payload.split('|')[3];
    final String endTime = payload.split('|')[4];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              height: AppConst.kHeight * 0.6,
              width: AppConst.kWidth,
              decoration: BoxDecoration(
                color: AppConst.kBkLight,
                borderRadius: BorderRadius.circular(AppConst.kRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  const HeightSpacer(spaceHeight: 10),
                  ReusableText(
                    style: appStyle(26, AppConst.kLight, FontWeight.bold),
                    text: 'Reminder',
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: AppConst.kYellow,
                      borderRadius: BorderRadius.circular(AppConst.kRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReusableText(
                          style:
                              appStyle(14, AppConst.kBkDark, FontWeight.bold),
                          text: "Today",
                        ),
                        const Spacer(),
                        ReusableText(
                          style:
                              appStyle(14, AppConst.kBkDark, FontWeight.bold),
                          text: 'From $startTime To $endTime',
                        ),
                      ],
                    ),
                  ),
                  const HeightSpacer(spaceHeight: 10),
                  ReusableText(
                    style: appStyle(20, AppConst.kBkDark, FontWeight.bold),
                    text: title,
                  ),
                  Text(
                    content,
                    style: appStyle(14, AppConst.kLight, FontWeight.bold),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppConst.notification,
                width: AppConst.kWidth * 0.8,
              ),
            )
          ],
        ),
      ),
    );
  }
}
