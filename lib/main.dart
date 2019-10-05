import 'package:bloc_bases/ui/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: TextTheme(
                headline: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                title: TextStyle(
                    color: Colors.black.withOpacity(0.70),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                subtitle: TextStyle(
                    color: Colors.black.withOpacity(0.64),
                    fontSize: 11,
                    fontWeight: FontWeight.w300),
                body1: TextStyle(
                    color: Colors.black.withOpacity(0.54),
                    fontSize: 14,
                    fontWeight: FontWeight.w300))),
        home: LoginPage());
  }
}
