import 'package:flutter/material.dart';
import 'package:lodge_management_app/models/room.dart';

class BookingPage extends StatelessWidget {
  final Room room;

  const BookingPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${room.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Room: ${room.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement your booking logic here
                // This is just a dummy button
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Booking Confirmation'),
                    content: Text('Booking for ${room.name} successful!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Book Room'),
            ),
          ],
        ),
      ),
    );
  }
}
