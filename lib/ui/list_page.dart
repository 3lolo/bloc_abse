import 'package:bloc_bases/bloc/data_list_paging/bloc.dart';
import 'package:bloc_bases/bloc/data_list_paging/state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';
import 'package:bloc_bases/ui/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPage extends StatelessWidget {
  final FilmDataRepository filmDataRepository = FilmDataRepository();
  final DataListType listType;
  ListPage(this.listType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text(listType.toString().split(".").last.replaceAll("_", " "))),
        body: BlocProvider(
            builder: (context) => DataListPagingBloc(filmDataRepository),
            child: _ListPageWidgete(listType)));
  }
}

class _ListPageWidgete extends StatefulWidget {
  final DataListType listType;

  _ListPageWidgete(this.listType);

  _ListPageState createState() => _ListPageState(listType);
}

class _ListPageState extends State<_ListPageWidgete> {
  final DataListType listType;
  final _scrollController = ScrollController();
  DataListPagingBloc _bloc;

  _ListPageState(this.listType);

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DataListPagingBloc>(context);
    _bloc.fetchData(listType, null, 10);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListPagingBloc, DataListState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is EmptyState) {
          return Center(child: Text("No data"));
        } else if (state is SuccessState) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) =>
                _handleScrollNotification(notification, state),
            child: ListView.builder(
              itemBuilder: (context, index) => (index >= state.result.length)
                  ? _buildProgress()
                  : _buildListItem(state.result[index]),
              controller: _scrollController,
              itemCount: _getItemsCount(state),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool _handleScrollNotification(
      ScrollNotification notification, SuccessState state) {
    if (!state.isLoadingEnabled) return false;

    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _bloc.fetchData(listType, state.result, 10);
    }

    return false;
  }

  int _getItemsCount(SuccessState state) =>
      state.result.length + (state.isLoadingEnabled ? 1 : 0);

  Widget _buildProgress() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildListItem(MediaThumbModel thumb) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.black12,
                )
              ],
              borderRadius: new BorderRadius.all(Radius.circular(4.0))),
          child: GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  child: Image.network(thumb.imageLargeUrl,
                      width: 180, height: 250, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Container(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${thumb.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            "${thumb.studio}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16.0),
                              child: Text(
                                "${thumb.description}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 9,
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            color: Colors.black12,
                            height: 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${thumb.genres}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            onTap: () => _actionClicked(thumb),
          ),
        ),
      );

  _actionClicked(MediaThumbModel thumb) {
    print("click");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(film: thumb)),
    );
  }
}
