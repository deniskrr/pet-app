import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/chat/chats_overview_page.dart';
import 'package:pet_app/screens/home/profile/profile_page.dart';
import 'package:pet_app/screens/home/search/search_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProfilePage(),
    SearchPage(),
    ChatsOverviewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("My Account"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text("Chats"),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}