import 'dart:io';

import 'package:bloc_bases/data/model/film_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final FilmModel film;
  const DetailPage({Key key, @required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailPageWidgete(film: film);

    // Scaffold(
    //     appBar: AppBar(title: Text('Home Page')),
    //     body: _DetailPageWidgete(film: film));
    // //   BlocProvider(
    //       builder: (context) => HomeBloc(filmDataRepository),
    //       child: _DetailPageWidgete()),
    // );
  }
}

class _DetailPageWidgete extends StatefulWidget {
  final FilmModel film;
  _DetailPageWidgete({Key key, @required this.film}) : super(key: key);

  __DetailPageWidgeteState createState() => __DetailPageWidgeteState(film);
}

class __DetailPageWidgeteState extends State<_DetailPageWidgete> {
  final FilmModel filmModel;

  __DetailPageWidgeteState(this.filmModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('SliverAppBar'),
          backgroundColor: Colors.green,
          expandedHeight: 400.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(filmModel.url, fit: BoxFit.cover),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ConstrainedBox(  constraints: new BoxConstraints(minHeight: 100),child: Text("gg")), 
              // Container(
              //     alignment: Alignment.center,
              //     color: Colors.red,
              //     height: 400,
              //     child: Text("gg wp")),

              // Container(
              //   child: Column(
              //     children: <Widget>[
              //       Row(children: <Widget>[
              //         // Text("${filmModel.name}"),
              //         Text("like")
              //       ]),
              //       Text(filmModel.athour),
              //       Row(
              //         children: <Widget>[Text("stars"), Text("see reviews")],
              //       )
              //     ],
              //   ),
              // ),
              Container(color: Colors.orange, height: 200),
              Container(color: Colors.yellow, height: 200),
              Container(color: Colors.pink, height: 200),
              // Container(
              //   height: 200,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.max,
              //     children: <Widget>[
              //       Text("About book"),
              //       Text("${filmModel.description}")
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ));
  }
}
