import 'package:bloc_bases/bloc/login_bloc.dart';
import 'package:bloc_bases/widget/item_book_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore pasword'),
      ),
      body: BlocProvider(
          builder: (context) => LoginBloc(), child: _HomePageWidgete()),
    );
  }
}

class _HomePageWidgete extends StatefulWidget {
  _HomePageWidgete({Key key}) : super(key: key);

  __HomePageWidgeteState createState() => __HomePageWidgeteState();
}

class __HomePageWidgeteState extends State<_HomePageWidgete> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:24.0, right: 24.0),
      child: ListView(
        children: <Widget>[ItemBookThumb(), ItemBookThumb()],
      ),
    );
  }
}
