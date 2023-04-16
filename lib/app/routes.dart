import 'package:checkit/screens/taskscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/loginscreen.dart';
import '../screens/nointernetsplash.dart';
import '../screens/splashscreen.dart';

class AppRoutes {
  static const splashRoute = '/SplashScreen';
  static const noInternetRoute = '/NoInternetScreen';
  static const loginRoute = '/LoginScreen';
  static const homeRoute = '/HomeScreenRoute';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
            settings: settings,
          );
        }
      case homeRoute:
        {
          return MaterialPageRoute(
              builder: (_) => const TaskScreen(), settings: settings);
        }
      case noInternetRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const NoInternetScreen(),
            settings: settings,
          );
        }
      case loginRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: settings,
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
            settings: settings,
          );
        }
    }
  }
}
