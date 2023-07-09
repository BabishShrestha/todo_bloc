import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  );

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        // designSize: const Size(375, 825),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return DynamicColorBuilder(
              builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              title: 'Todo Riverpod',
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kBkDark,
                // colorScheme: ColorScheme.fromSeed(
                //   seedColor: AppConst.kYellow,
                // ),
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                scaffoldBackgroundColor: AppConst.kBkDark,
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            );
          });
        });
  }
}
