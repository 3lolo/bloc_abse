import 'package:bloc_bases/data/model/media.dart';
import 'package:bloc_bases/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookThumb extends StatelessWidget {
  final MediaThumbModel data;
  final Function(MediaThumbModel) onClick;
  ItemBookThumb({Key key, @required this.data, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: GestureDetector(
          onTap: () => onClick(data),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.black12.withOpacity(0.1),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                  child: Image.network(
                    data.imageLargeUrl,
                    fit: BoxFit.fill,
                    height: 180.0,
                    width: 130.0,
                  ),
                ),
                Container(
                    color: Colors.black.withOpacity(0.05),
                    width: 130.0,
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 4, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: Theme.of(context).textTheme.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          data.studio,
                          style: Theme.of(context).textTheme.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data.genres,
                            style: Theme.of(context).textTheme.body1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
