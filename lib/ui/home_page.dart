import 'package:bloc_bases/bloc/bloc.dart';
import 'package:bloc_bases/bloc/home/home_bloc.dart';
import 'package:bloc_bases/bloc/home/home_state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';
import 'package:bloc_bases/ui/list_page.dart';
import 'package:bloc_bases/widget/item_book_more.dart';
import 'package:bloc_bases/widget/item_book_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final FilmDataRepository filmDataRepository = FilmDataRepository();

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          builder: (context) => HomeBloc(filmDataRepository),
          child: _HomePageWidgete()),
    );
  }
}

class _HomePageWidgete extends StatefulWidget {
  __HomePageWidgeteState createState() => __HomePageWidgeteState();
}

class __HomePageWidgeteState extends State<_HomePageWidgete> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is InitialHomeState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is EmptyHomeState) {
        return Center(child: Text("No data"));
      } else if (state is SuccessHomeState) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              _builderWithTitle(index, state),
          itemCount: state.result.length * 2,
        );
      } else {
        return Container();
      }
    });
  }

  Widget _builderWithTitle(int index, SuccessHomeState state) {
    int position = index ~/ 2;
    MapEntry<String, List<MediaThumbModel>> entry =
        state.result.entries.elementAt(position);
    if (index % 2 == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 4.0, bottom: 4),
        child: Text(
          entry.key,
          style: Theme.of(context).textTheme.headline,
        ),
      );
    } else {
      return Container(
        height: 254,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _builder(
                context, index, entry.value,  position),
            itemCount: entry.value.length + 1),
        padding: EdgeInsets.only(bottom: 8, top: 5),
      );
    }
  }

  Widget _builder(BuildContext context, int index, List<MediaThumbModel> data,int position) {

    if (data.length > index) {
      return Padding(
        padding: EdgeInsets.only(left: (index == 0) ? 8.0 : 0, right: 8.0),
        child: ItemBookThumb(
            data: data[index], onClick: (data) => _actionClick(data)),
      );
    } else {
    var type  = DataListType.values[position];
    print("index $type position $position");
      return ItemBookThumbMore(onClick: (data) => _actionClick2(data, type));
    }
  }

  _actionClick(MediaThumbModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(film: data)),
    );
  }

  _actionClick2(String data, DataListType type) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage(type)),
    );
  }
}
