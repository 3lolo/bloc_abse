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
    return Material(
        type: MaterialType.transparency, child: _DetailPageWidgete(film: film));

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
        color: Colors.white,
        child: Stack(children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('${filmModel.name}'),
                backgroundColor: Colors.blue,
                expandedHeight: 400.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(filmModel.url, fit: BoxFit.cover),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, top: 100),
                  child: Text("About this book"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 16, right: 16, bottom: 100),
                  child: Text("${filmModel.description}"),
                )
              ])),
            ],
          ),
          Positioned(
            top: 200,
            child: Container(color: Colors.amber, height: 200, width: 300,),
          )
        ]));
  }
}
