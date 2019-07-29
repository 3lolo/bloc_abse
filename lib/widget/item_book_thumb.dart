import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookThumb extends StatefulWidget {
  ItemBookThumb({Key key}) : super(key: key);

  _ItemBookThumbState createState() => _ItemBookThumbState();
}

class _ItemBookThumbState extends State<ItemBookThumb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new ClipRRect(
          borderRadius: new BorderRadius.circular(4.0),
          child: Image.network(
            'https://picsum.photos/250?image=9',
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
                    Text("Title"),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Text("by Rachel "),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Text("Stars"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Text("1,374 Reviews"),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
