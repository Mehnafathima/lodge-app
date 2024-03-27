import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/room.dart';
import 'package:lodge_management_app/pages/booking_page.dart';

class MainPage extends StatelessWidget {
  final List<Room> rooms; // List of rooms

  const MainPage({Key? key, required this.rooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter rooms with status true
    final List<Room> availableRooms = rooms.where((room) => room.status).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0, // Adjust the spacing between columns
            mainAxisSpacing: 16.0, // Adjust the spacing between rows
            childAspectRatio: 0.8, // Adjust the aspect ratio of grid items
          ),
          itemCount: availableRooms.length,
          itemBuilder: (context, index) {
            final Room room = availableRooms[index];
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Add rounded corners to the container
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 123, 172, 125), // Start color
                      Color.fromARGB(255, 171, 241, 59), // End color
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    room.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
