import 'package:flutter/material.dart';
import 'package:todo_riverpod/features/auth/pages/otp_page.dart';
import 'package:todo_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String otp = '/otp';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnBoarding());

      case login:
        return MaterialPageRoute(builder: (context) => const OnBoarding());
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OTPPage(
                  phone: args['phone'],
                  smsCodeId: args['smsCodeId'],
                ));
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
