import 'package:flutter/material.dart';
import 'package:stat3management_lab/_todo/_app.dart';

import '_calculator/_app.dart';
import 'mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF5F9FA),
      ),

      initialRoute: '/homeScreen',
      routes: {
        '/homeScreen': (context)=> HomeScreen(),
        '/todo_app': (context)=> TODOApp(),
        '/calculator_app': (context)=> Calculator_app(),
      },
    );
  }
}




