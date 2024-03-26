import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/room.dart';
import 'package:lodge_management_app/pages/booking_page.dart';
// Import the booking page

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated list of rooms (replace with your actual logic to fetch rooms)
    final List<Room> rooms = []; // Initialize as an empty list for now

    // Filter rooms with status true
    final availableRooms = rooms.where((room) => room.status == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: availableRooms.length,
        itemBuilder: (context, index) {
          final room = availableRooms[index];
          return GestureDetector(
            onTap: () {
              // Navigate to booking page when room is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(room: room),
                ),
              );
            },
            child: Container(
              color: Colors.blueGrey,
              child: const Center(
                child: Icon(Icons.room), // Placeholder icon
              ),
            ),
          );
        },
      ),
    );
  }
}
