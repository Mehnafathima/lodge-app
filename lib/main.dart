import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.green),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 10, 68, 12),
          foregroundColor: Colors.white //here you can give the text color,
  
          )
     ),
      
      home: const LoginPage(),
    );
  }
}