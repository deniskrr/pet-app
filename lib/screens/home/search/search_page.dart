import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/search/pet/pet_search_page.dart';
import 'package:pet_app/screens/home/search/pet_sitter/pet_sitter_search_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
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
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.pets),
            ),
            Tab(
              icon: Icon(Icons.accessibility),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          PetSearchPage(),
          PetSitterSearchPage(),
        ],
      ),
    );
  }
}
