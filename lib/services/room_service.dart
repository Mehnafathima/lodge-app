
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'rooms';

  // Create a new room
  Future<void> addRoom(Map<String, dynamic> roomData) async {
    await _firestore.collection(_collectionName).add(roomData);
  }

  // Read all rooms
  Stream<List<DocumentSnapshot>> getRooms() {
    return _firestore.collection(_collectionName).snapshots().map(
          (snapshot) => snapshot.docs,
        );
  }

  // Update an existing room
  Future<void> updateRoom(String roomId, Map<String, dynamic> newData) async {
    await _firestore.collection(_collectionName).doc(roomId).update(newData);
  }

  // Delete a room
  Future<void> deleteRoom(String roomId) async {
    await _firestore.collection(_collectionName).doc(roomId).delete();
  }
}
