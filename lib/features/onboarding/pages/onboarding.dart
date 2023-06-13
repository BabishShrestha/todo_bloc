import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';

import '../../../core/widgets/spacer.dart';
import '../widgets/ending.dart';
import '../widgets/intro.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              Intro(),
              Ending(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease);
                        },
                        icon: const Icon(Ionicons.chevron_forward_circle,
                            size: 30, color: AppConst.kLight),
                      ),
                      const WidthSpacer(
                        spaceWidth: 5,
                      ),
                      ReusableText(
                        text: 'Skip',
                        style: appStyle(16, AppConst.kLight, FontWeight.w500),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 10,
                        dotColor: AppConst.kYellow,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
