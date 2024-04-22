import 'package:flutter/material.dart';
import 'package:lodge_management_app/pages/main_page.dart';
import 'package:lodge_management_app/pages/room_list.dart';
import 'package:lodge_management_app/pages/calendar_page.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3, // Assuming you have 3 tabs in your IndexedStack
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  int _currentIndex = 1; // Assuming Home tab is the second tab initially
Color customColor = const Color(0xFFCDBCDB);
Color selectedColor = const Color(0xFF82659D);
Color orangeColor = const Color(0xFFF0743E);
Color appBarColor = const Color(0xFFFDD848);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: const Text("L E D G E R", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        foregroundColor: appBarColor,
        backgroundColor: Colors.transparent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CalendarPage(),
          RoomList(), // RoomList is the first page now
          MainPage(), // MainPage is now the second page
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Analytics", "Home", "Bookings"],
        icons: const [Icons.analytics, Icons.home, Icons.add_business],
        textStyle:  TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: customColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: selectedColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _currentIndex = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
