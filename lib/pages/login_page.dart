import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage class

class LoginPage extends StatefulWidget {
 const  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(


//       backgroundColor: Colors.lightGreen[100],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 // logo animation
//                 Image.asset(
//                   'assets/images/book_animation.gif',
//                   width: 300,
//                   height: 300,
//                   fit: BoxFit.fill, // Adjust this based on your layout needs
//                 ),
//                 // text
//                 Text(
//                   'P H   R E S I D E N C Y',
//                   style: TextStyle(
//                       color: Colors.green[900],
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 50),

//                 // Password TextField
//                 Container(
//                   width: 300,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.lightGreen[200],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 21, 60, 22),
//                         ),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.lock,
//                         color: Colors.green[900],
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     obscureText: true,
//                     maxLength: 6,
//                     onEditingComplete: () {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => HomePage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/book_animation.gif',
                  width: screenWidth * 0.8, // Adjust as needed
                  height: screenWidth * 0.8, // Maintain aspect ratio
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 50),
                Text(
                  'P H   R E S I D E N C Y',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: screenWidth * 0.04, // Adjust as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.lightGreen[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 21, 60, 22),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green[900],
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 6,
                    onEditingComplete: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}