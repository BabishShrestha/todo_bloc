import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/models/user_model.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/features/auth/controllers/code_bloc.dart';
import 'package:todo_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

import 'core/routes/routes.dart';
import 'features/auth/controllers/user_controller.dart';
import 'firebase_options.dart';

void main() async {
  // DBHelper.initDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  static final defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  );

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<User> users = ref.watch(userProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CodeCubit>(
          create: (context) => CodeCubit(),
        ),
      
      ],
      child: ScreenUtilInit(
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
                home: Center(child: users.isEmpty ? const OnBoarding() : const HomePage()),
                onGenerateRoute: Routes.onGenerateRoute,
              );
            });
          }),
    );
  }
}
