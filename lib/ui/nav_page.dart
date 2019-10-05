import 'package:bloc_bases/ui/appBottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavPage extends StatelessWidget {
  NavPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigationBarController();
  }
}
