// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/routes.dart';

/* Created by Jasraj*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  bool hasInternet = true;
  late final String? action;
  String route = AppRoutes.loginRoute;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    action = prefs.getString('id');
    print(action);
    if (action != null) {
      route = AppRoutes.homeRoute;
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    _navigateToBuilderScreen();
  }

  _navigateToBuilderScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    hasInternet = await InternetConnectionChecker().hasConnection;

    if (hasInternet) {
      Navigator.of(context).pushReplacementNamed(
        route,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.noInternetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('images/to-do-list.png'),
              height: animation.value * 100,
              width: animation.value * 100,
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              'CHECKIT',
              style: TextStyle(
                fontSize: animation.value * 40,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
