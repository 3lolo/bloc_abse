import 'package:bloc_bases/data/model/film_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookThumb extends StatelessWidget {
  final FilmModel data;
  ItemBookThumb({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new ClipRRect(
          borderRadius: new BorderRadius.circular(4.0),
          child: Image.network(
            data.url,
            fit: BoxFit.fill,
            height: 258.0,
            width: 170.0,
          ),
        ),
        Expanded(
            flex: 1,
            child: Material(
              elevation: 10.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(27.0),
                      bottomRight: Radius.circular(27.0))),
              child: Padding(
                padding: const EdgeInsets.only(top: 35, bottom: 25),
                child: Column(
                  children: <Widget>[
                    Text(data.name),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Text(data.athour),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Text("${data.rating}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Text("${data.reviewsCount} Reviews"),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
