import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/search/pet/pet_search_page.dart';
import 'package:pet_app/screens/home/search/pet_sitter/pet_sitter_search_page.dart';
import 'package:pet_app/screens/home/search/service/service_search_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text("Search away!",
//          style: TextStyle(fontFamily: "helvetica"),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Mate",
              icon: Icon(Icons.pets),
            ),
            Tab(
              text: "Pet Sitter",
              icon: Icon(Icons.accessibility_new),
            ),
            Tab(
              text: "Pet Services",
              icon: Icon(Icons.assistant),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          PetSearchPage(),
          PetSitterSearchPage(),
          ServiceSearchPage()
        ],
      ),
    );
  }
}
