import 'package:bloc_bases/bloc/bloc.dart';
import 'package:bloc_bases/bloc/details/details_bloc.dart';
import 'package:bloc_bases/bloc/details/details_state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final MediaThumbModel film;
  final FilmDataRepository filmDataRepository = FilmDataRepository();

  DetailPage({Key key, @required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(film.id);
    var film2 = MediaModel(film.id, "", "", "", "", "", "", 0, 0);
    return Material(
        type: MaterialType.transparency,
        child: BlocProvider(
            builder: (context) => DetailsBloc(filmDataRepository),
            child: _DetailPageWidgete(film: film2)));
  }
}

class _DetailPageWidgete extends StatefulWidget {
  final MediaModel film;
  _DetailPageWidgete({Key key, @required this.film}) : super(key: key);

  __DetailPageWidgeteState createState() => __DetailPageWidgeteState(film);
}

class __DetailPageWidgeteState extends State<_DetailPageWidgete> {
  DetailsBloc _bloc;
  final MediaModel filmModel;

  __DetailPageWidgeteState(this.filmModel);

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DetailsBloc>(context);
    _bloc.fetchData(filmModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      if (state is InitialDetailsState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is EmptyHomeState) {
        return Center(child: Text("No data"));
      } else if (state is SuccessDetailsState) {
        return getWidgete(state.result);
      } else {
        return Container();
      }
    });
  }

  getWidgete(MediaModel media) {
    return Container(
        color: Colors.white,
        child: Stack(children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('${media.title}'),
                backgroundColor: Colors.blue,
                expandedHeight: 400.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(media.imageUrl, fit: BoxFit.cover),
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
                  child: Text("${media.title}"),
                )
              ])),
            ],
          ),
          Positioned(
            top: 342,
            left: 30,
            right: 26,
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${media.title}'),
                            Text("heart")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[Text('by ${media.title}')],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 21.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text("stars"), Text("Reviews")],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
