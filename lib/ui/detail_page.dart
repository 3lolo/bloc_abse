import 'package:bloc_bases/bloc/bloc.dart';
import 'package:bloc_bases/bloc/details/details_bloc.dart';
import 'package:bloc_bases/bloc/details/details_state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatelessWidget {
  final MediaThumbModel film;
  final FilmDataRepository filmDataRepository = FilmDataRepository();

  DetailPage({Key key, @required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(film.id);
    return Material(
        type: MaterialType.transparency,
        child: BlocProvider(
            builder: (context) => DetailsBloc(filmDataRepository),
            child: _DetailPageWidgete(film: film)));
  }
}

class _DetailPageWidgete extends StatefulWidget {
  final MediaThumbModel film;
  _DetailPageWidgete({Key key, @required this.film}) : super(key: key);

  __DetailPageWidgeteState createState() => __DetailPageWidgeteState(film);
}

class __DetailPageWidgeteState extends State<_DetailPageWidgete> {
  DetailsBloc _bloc;
  final MediaThumbModel film;

  __DetailPageWidgeteState(this.film);

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DetailsBloc>(context);
    _bloc.fetchData(film.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      if (state is InitialDetailsState) {
        return getInitWidgete(film);
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
                  background:
                      Image.network(media.imageLargeUrl, fit: BoxFit.cover),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          media.title,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: GestureDetector(
                            onTap: () =>
                                setState(() => media.isSaved = !media.isSaved),
                            child: Icon(
                              media.isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.blue,
                            )),
                      ),
                      GestureDetector(
                          onTap: () => setState(
                              () => media.isLikedByMe = !media.isLikedByMe),
                          child: Icon(
                            media.isLikedByMe
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, right: 16.0),
                          child: Text(
                            "${media.format}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 16.0),
                            child: Text(
                              "${media.startDate} ${media.format =="TV"?"- ${media.endDate}":""}",
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 14.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, right: 16.0),
                          child: Text(
                            "${media.favourites}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        Icon(
                          Icons.thumb_up,
                          color: Colors.grey,
                          size: 14.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, right: 8.0),
                          child: Text(
                            "${media.popularity}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    var data = media.genres
                        .map((s) => Container(
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(4.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(s,
                                  style: Theme.of(context).textTheme.body1),
                            )))
                        .toList();

                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      direction: Axis.horizontal,
                      children: data,
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
                  child: Html(
                    data: "${media.description}",
                    defaultTextStyle: Theme.of(context).textTheme.body1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: YoutubePlayer(
                    context: context,
                    videoId: YoutubePlayer.convertUrlToId(
                        "https://www.youtube.com/watch?v=izWEmnpmTKM"),
                    flags: YoutubePlayerFlags(isLive: false, autoPlay: true),
                    // flags: YoutubePLayerFlags(
                    //   isLive: true,
                    // ),
                    liveUIColor: Colors.amber,
                  ),
                ),
              ])),
            ],
          ),
        ]));
  }

  getInitWidgete(MediaThumbModel media) {
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
                  background:
                      Image.network(media.imageLargeUrl, fit: BoxFit.cover),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      [Center(child: CircularProgressIndicator())])),
            ],
          ),
        ]));
  }
}
