import 'package:bloc_bases/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_page copy.dart';
import 'favourite_page.dart';

class AppBottomNavigationBarController extends StatefulWidget {
  @override
  _AppBottomNavigationBarControllerState createState() =>
      _AppBottomNavigationBarControllerState();
}

class _AppBottomNavigationBarControllerState
    extends State<AppBottomNavigationBarController> {
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> pages = [HomePage(), FavouritePage(), AccountPage()];
  int _selectedIndex = 0;

  Widget _bottomNavigationBar() => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favourite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
