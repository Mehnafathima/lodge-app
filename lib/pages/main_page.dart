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
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.hotel,
                      size: 24,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Available Rooms',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
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
                            color: Colors.grey.withOpacity(0.5),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
