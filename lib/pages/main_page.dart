import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
 const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Todays Account',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green[900],
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          //here i need a total of money collected that day , and if i recieve it on the smae day the status should turn green

          Expanded(
            child: ListView.builder(
              itemCount: 9, // Number of ListViews
              itemBuilder: (context, index) {
                return  Container(
                  height: 100, // Set your desired height for each ListView
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 193, 208, 197),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room $index',
                              style:const  TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Add more widgets as needed for your content
                            // For example, you can add ListTile, Image, etc.
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Pay button is being pressed for the list no: $index');
                          }
                        },
                        child:const  Text('Pay'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        
        ],
      ),
    );
  }
}
