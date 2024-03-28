import 'package:flutter/material.dart';
import 'package:lodge_management_app/pages/main_page.dart';
import 'package:lodge_management_app/pages/room_list.dart';
import 'package:lodge_management_app/pages/calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1; // Set initial index to RoomList

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("L E D G E R"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CalendarPage(),
          RoomList(), // RoomList is the first page now
          MainPage(), // MainPage is now the second page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 10, 68, 12),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle navigation to different pages
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}
