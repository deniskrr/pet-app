import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/screens/home/profile/profile_page.dart';
import 'package:pet_app/screens/home/search/pet/pet_search_page.dart';
import 'package:pet_app/screens/home/search/pet_sitter/pet_sitter_search_page.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int searchIndex = 0;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Pet App"),
        bottom: TabBar(
          onTap: (index) {
            setState(() {
              //Needed to rebuild the TabBar (to make the search switch appear or disappear)
            });
          },
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.account_circle),
            ),
            Tab(
              child: _tabController.index == 1
                  ? ToggleSwitch(
                      minWidth: 50,
                      activeBgColor: Colors.transparent,
                      activeTextColor: Colors.white,
                      inactiveBgColor: Colors.transparent,
                      inactiveTextColor: Colors.white,
                      initialLabelIndex: searchIndex,
                      labels: ['', ''],
                      onToggle: (index) {
                        _tabController.animateTo(1);
                        setState(() {
                          searchIndex = index;
                        });
                      },
                      activeColors: [Colors.green, Colors.amberAccent],
                      icons: [
                        Icons.pets,
                        Icons.accessibility,
                      ],
                    )
                  : Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.chat),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ProfilePage(),
          searchIndex == 0 ? PetSearchPage() : PetSitterSearchPage(),
          ChatPage(),
        ],
      ),
    );
  }
}
