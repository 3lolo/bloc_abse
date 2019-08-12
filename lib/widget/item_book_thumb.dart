import 'package:bloc_bases/data/model/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookThumb extends StatelessWidget {
  final MediaThumbModel data;
  final Function(MediaThumbModel) onClick;
  ItemBookThumb({Key key, @required this.data, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onClick(data),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new ClipRRect(
              borderRadius: new BorderRadius.circular(4.0),
              child: Image.network(
                data.image,
                fit: BoxFit.fill,
                height: 258.0,
                width: 170.0,
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(27.0),
                            bottomRight: Radius.circular(27.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 25),
                      child: Column(
                        children: <Widget>[
                          Text(data.title),
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Text(data.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text("${data.averageScore}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text("${data.favourites} Reviews"),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
