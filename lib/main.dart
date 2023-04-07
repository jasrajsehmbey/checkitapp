// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'package:provider/provider.dart';

import 'core/notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToDoItems>(
      create: (context) => ToDoItems(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splashRoute,
      ),
    );
  }
}
