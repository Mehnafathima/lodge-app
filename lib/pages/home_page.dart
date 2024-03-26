import 'package:flutter/material.dart';
import 'package:lodge_management_app/customs/drawer_list.dart';
import 'package:lodge_management_app/pages/manage_customer.dart';
import 'package:lodge_management_app/pages/manage_room.dart';
import 'main_page.dart';
import 'room_list.dart';
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  // Create a list of pages to navigate to
  final List<Widget> _pages =  [
    const MainPage(),
    const RoomList(),
    const CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "L E D G E R",
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 10, 68, 12),
              ),
              child: Center(
                child: Text(
                  'Manage Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
           DrawerTile(
              icon: Icons.bed_outlined,
              title: 'Manage Room',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoomPage()),
                );
              },
            ),
            DrawerTile(
              icon: Icons.person_2,
              title: 'Manage Customer',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const CustomerPage()),
                );
              },
            ),
            // Add more list tiles for other data management options if needed
          ],
        ),
      ),

      body: _pages[_currentIndex], // Display the current page
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
