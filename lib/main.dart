import 'package:flutter/material.dart';
import 'package:gestcondo/pages/login_page.dart';

void main() {
  runApp(GestCondoApp());
}

class GestCondoApp extends StatelessWidget {
  const GestCondoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestCondo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue
      ),
      home: const LoginPage(),
    );
  }
}