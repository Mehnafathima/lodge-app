import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lodge_management_app/firebase_options.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white //here you can give the text color,
  
          )
     ),
      
      home: const LoginPage(),
    );
  }
}
 // // Removed Text widget if not needed
        // backgroundColor: Colors.transparent, // Make AppBar transparent
        // flexibleSpace: const Image(
        //   image: AssetImage("assets/images/bunny.jpg"),
        //   fit: BoxFit.fill,
        // ),