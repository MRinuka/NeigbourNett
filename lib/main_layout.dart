import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'screens/home_page.dart';
import 'screens/activities_page.dart';
import 'screens/wall_page.dart';
import 'screens/post_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // **the pages in my navbar**
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const PostPage(),
    const ActivitiesPage(),
    const WallPage(),
  ];


  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Image.asset(
          "assets/images/NeighbourNett New.png",
          height: 100,
          width: 100,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, "/chat");
          //
          //   },
          //   icon: const Icon(CupertinoIcons.chat_bubble_fill),
          //   color: Colors.lightBlueAccent,
          // ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: Colors.lightBlueAccent,
            onPressed: () {
              // TODO: Handle notification tap
            },
          ),
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 15,),
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, Icons.home, 0),
                // _buildNavItem(CupertinoIcons.plus_app, CupertinoIcons.plus_app_fill, 1),
                _buildNavItem(Icons.local_activity_outlined, Icons.local_activity, 2),
                _buildNavItem(CupertinoIcons.collections, CupertinoIcons.collections_solid, 3)
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
            ),
          ),
        ],
      ),
    );
  }

  // This helper widget is now part of _MainLayoutState
  Widget _buildNavItem(
      IconData unselectedIcon, IconData selectedIcon, int index) {
    final bool isSelected = _selectedIndex == index;
    final color =
    isSelected ? Colors.lightBlueAccent.shade100 : Colors.lightBlueAccent.shade100;

    return InkWell(
      onTap: () => onItemTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? selectedIcon : unselectedIcon, color: color, size: 40.0,),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}