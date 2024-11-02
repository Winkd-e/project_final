

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projects/Splashscreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'OptiFood',
       theme: ThemeData(),
       debugShowCheckedModeBanner: false,
       home: const SplashScreen(),
    );
  }
}
