import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  String? _typeValue;
  bool _statusValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Set this property to true
      appBar: AppBar(
        title: const Text('R O O M'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('rooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<QueryDocumentSnapshot> roomDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: roomDocs.length,
              itemBuilder: (context, index) {
                var roomData = roomDocs[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 4, // Adding elevation to the card
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white, // Setting background color of the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      roomData['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(roomData['type']),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _nameController.text = roomData['name'];
                        _typeValue = roomData['type'];
                        _statusValue = roomData['status'];
                        _showRoomFormModal(context, roomId: roomDocs[index].id);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRoomFormModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showRoomFormModal(BuildContext context, {String? roomId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomId == null ? 'Add Room' : 'Edit Room',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Room Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _typeValue,
                  onChanged: (value) {
                    setState(() {
                      _typeValue = value;
                    });
                  },
                  items: ['Option 1', 'Option 2'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('Status'),
                  value: _statusValue,
                  onChanged: (value) {
                    setState(() {
                      _statusValue = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (roomId == null) {
                          _addRoom();
                        } else {
                          _updateRoom(roomId);
                        }
                        Navigator.pop(context); // Close dialog
                      },
                      child: Text(roomId == null ? 'Add' : 'Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addRoom() {
    _firestore.collection('rooms').add({
      'name': _nameController.text,
      'type': _typeValue,
      'status': _statusValue,
    });
    _clearForm();
  }

  void _updateRoom(String roomId) {
    _firestore.collection('rooms').doc(roomId).update({
      'name': _nameController.text,
      'type': _typeValue,
      'status': _statusValue,
    });
    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _typeValue = null;
    _statusValue = false;
  }
}
