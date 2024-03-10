// pages/home_page.dart

import 'package:flutter/material.dart';
import 'main_page.dart';
import 'room_list.dart';
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  // Create a list of pages to navigate to
  final List<Widget> _pages = [
    const MainPage(),
    const RoomList(),
    const CalendarPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Removed Text widget if not needed
        backgroundColor: Colors.transparent, // Make AppBar transparent
        flexibleSpace: const Image(
          image: AssetImage("assets/images/bunny.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.white10,
        selectedItemColor: const Color.fromARGB(255, 10, 68, 12),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
        onTap: (index) {
          // Handle navigation to different pages
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
