import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/screens/home/profile/profile_page.dart';
import 'package:pet_app/screens/home/search/search_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_circle),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.chat),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProfilePage(),
            SearchPage(),
            ChatPage(),
          ],
        ),
      ),
    );
  }
}
