import 'package:flutter/material.dart';

import '../app/routes.dart';

/* Created by Jasraj*/
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('images/to-do-list.png'),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 36,
            ),
            const Text(
              'CHECKIT',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'You are not connected to the internet',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Text(
              'please try again.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 60,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.splashRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade400,
                ),
                child: const Text(
                  'RETRY',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
