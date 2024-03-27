import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lodge_management_app/models/booking.dart';

import 'package:lodge_management_app/models/room.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Room>> getRooms() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('rooms').get();

      List<Room> rooms = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Room(
          id: doc.id,
          name: data['name'] ?? '',
          status: data['status'] ?? false,
        );
      }).toList();

      return rooms;
    } catch (e) {
      throw Exception('Failed to fetch rooms: $e');
    }
  }

    Future<void> saveBookingData(Map<String, dynamic> bookingData) async {
    try {
      await _firestore.collection('bookings').add(bookingData);
    } catch (e) {
      print('Error saving booking data: $e');
      throw e; // Re-throw the error for handling in the UI
    }
  }

    Future<void> updateRoomStatus(Room room) async {
    try {
      await _firestore.collection('rooms').doc(room.id).update({'status': false});
    } catch (e) {
      print('Error updating room status: $e');
      throw e; // Re-throw the error for handling in the UI
    }
  }
}
