import 'package:flutter/material.dart';
import 'package:riverpod_template/src/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green.shade800,
      home: const HomePage(),
    );
  }
}
