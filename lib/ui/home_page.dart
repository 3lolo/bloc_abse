import 'package:bloc_bases/bloc/bloc.dart';
import 'package:bloc_bases/bloc/home/home_bloc.dart';
import 'package:bloc_bases/bloc/home/home_state.dart';
import 'package:bloc_bases/bloc/login_bloc.dart';
import 'package:bloc_bases/widget/item_book_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/film_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (
              BuildContext context,
              HomeState state,
            ) {
              if (state is SuccessHomeState)
                return _HomePageWidgete(state.result);
            }));
  }
}

class _HomePageWidgete extends StatefulWidget {
  final List<FilmModel> data;

  _HomePageWidgete(this.data);

  __HomePageWidgeteState createState() => __HomePageWidgeteState(data);
}

class __HomePageWidgeteState extends State<_HomePageWidgete> {
  List<FilmModel> data;
  __HomePageWidgeteState(List<FilmModel> data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ItemBookThumb(data: data[index]);
      },
      itemCount: data.length,
      // controller: _scrollController,
    );

    // return Padding(
    //   padding: const EdgeInsets.only(left: 24.0, right: 24.0),
    //   child: ListView(
    //     children: <Widget>[ItemBookThumb(), ItemBookThumb()],
    //   ),
    // );
  }
}
