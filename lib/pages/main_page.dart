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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
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
              color: Colors.blueGrey,
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
    );
  }
}
