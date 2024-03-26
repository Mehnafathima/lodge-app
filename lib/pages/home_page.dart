import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/room.dart'; // Import your room model
import 'package:lodge_management_app/pages/main_page.dart';
import 'package:lodge_management_app/pages/room_list.dart';
import 'package:lodge_management_app/pages/calendar_page.dart';
import 'package:lodge_management_app/services/firebase_service.dart'; // Import your Firebase service to fetch rooms

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late Future<List<Room>> _fetchRooms = Future.value([]); // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _fetchRooms = FirebaseService().getRooms(); // Fetch rooms from Firebase
  }

  // Create a list of pages to navigate to
  List<Widget> get _pages => [
    FutureBuilder<List<Room>>(
      future: _fetchRooms,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Once data is fetched, construct the MainPage with the fetched rooms
          return MainPage(rooms: snapshot.data!);
        }
      },
    ),
    const RoomList(),
    const CalendarPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("L E D G E R"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Room>>(
        future: _fetchRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Once data is fetched, construct the corresponding page
            return _pages[_currentIndex];
          }
        },
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
            icon: Icon(Icons.add_business),
            label: 'Bookings',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
