import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodge_management_app/models/room.dart';
import 'package:lodge_management_app/pages/booking_page.dart';
import 'package:lodge_management_app/services/firebase_service.dart';

final roomsProvider = FutureProvider<List<Room>>((ref) async {
  // Fetch rooms from Firebase here
  final List<Room> rooms = await FirebaseService().getRooms();
  return rooms;
});


class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsyncValue = ref.watch(roomsProvider);

    return roomsAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (rooms) {
        // Filter rooms with status true
        final availableRooms = rooms.where((room) => room.status).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Available Room'),
            backgroundColor: Color.fromARGB(255, 233, 169, 121), // Theme color
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.6, // Decrease the value to decrease container size
              ),
              itemCount: availableRooms.length,
              itemBuilder: (context, index) {
                final room = availableRooms[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(room: room),
                      ),
                    ).then((value) {
                      // Refresh rooms when returning from booking page
                      // ignore: unused_result
                      ref.refresh(roomsProvider);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 210, 193, 211), // Theme color
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hotel,
                          size: 36.0, // Adjust the size of the icon
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          room.name,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
