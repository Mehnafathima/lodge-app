import 'package:flutter/material.dart';

class RoomList extends StatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  bool _showAllRooms = false;
  final int _totalRooms = 15; // Total number of rooms available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.room_service,
                  size: 24,
                  color: Color.fromARGB(255, 107, 83, 146),
                ),
                SizedBox(width: 10),
                Text(
                  'Unpaid Rooms Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 107, 83, 146),
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
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _showAllRooms ? _totalRooms : 9,
                itemBuilder: (context, index) {
                  if (!_showAllRooms && index == 8 && _totalRooms > 9) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAllRooms = true;
                        });
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 165, 101, 153),
                              Color.fromARGB(255, 107, 83, 146),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'Show More',
                                style: TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (_showAllRooms && index == _totalRooms - 1) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAllRooms = false;
                        });
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 165, 101, 153),
                              Color.fromARGB(255, 107, 83, 146),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'Show Less',
                                style: TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 165, 101, 153),
                            Color.fromARGB(255, 107, 83, 146),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Room $index',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
