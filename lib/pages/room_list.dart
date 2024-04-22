import 'package:flutter/material.dart';

class RoomList extends StatelessWidget {
 const  RoomList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor:Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select a fvbdjhfverjhf',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.green[800]
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 222, 244, 224), // Change the color or replace with your widget
                      borderRadius: BorderRadius.circular(12.0),
                    ),// Change the color or replace with your widget
                    child: Center(
                      child: Text(
                        'yooo $index',
                        style: const TextStyle(fontSize: 12, color: Colors.white),
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
  }
}
