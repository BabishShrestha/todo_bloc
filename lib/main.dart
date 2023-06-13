import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        // designSize: const Size(375, 825),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Todo Riverpod',
            theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kBkDark,
                colorScheme: ColorScheme.fromSeed(seedColor: AppConst.kYellow)),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        });
  }
}
