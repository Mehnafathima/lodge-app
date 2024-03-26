import 'package:cloud_firestore/cloud_firestore.dart';
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
}
