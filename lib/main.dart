import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/models/user_model.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/features/auth/bloc/auth_cubit.dart';
import 'package:todo_riverpod/features/auth/bloc/country_code_cubit.dart';
import 'package:todo_riverpod/features/auth/bloc/user_cubit.dart';
import 'package:todo_riverpod/features/auth/repository/auth_repository.dart';
import 'package:todo_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_riverpod/features/todo/bloc/date_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/xpansion_cubit.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

import 'core/routes/routes.dart';

import 'firebase_options.dart';

void main() async {
  // DBHelper.initDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CodeCubit>(
          create: (context) => CodeCubit(),
        ),
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
                  authRepository:
                      AuthRepository(auth: fauth.FirebaseAuth.instance),
                )),
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<DateCubit>(create: (context) => DateCubit()),
        BlocProvider<StartTimeCubit>(create: (context) => StartTimeCubit()),
        BlocProvider<FinishTimeCubit>(create: (context) => FinishTimeCubit()),
        BlocProvider<TodoCubit>(create: (context) => TodoCubit()),
        BlocProvider<XpansionCubit>(create: (context) => XpansionCubit()),
        BlocProvider<XpansionCubit0>(create: (context) => XpansionCubit0()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          // designSize: const Size(375, 825),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            final userCubit = BlocProvider.of<UserCubit>(context);
            userCubit.refresh();

            // ref.read(userProvider.notifier).refresh();
            // List<User> users = ref.watch(userProvider);
            List<User> users = userCubit.state;

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
                home: Center(
                    child:
                        users.isEmpty ? const OnBoarding() : const HomePage()),
                onGenerateRoute: Routes.onGenerateRoute,
              );
            });
          }),
    );
  }
}
