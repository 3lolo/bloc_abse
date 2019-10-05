import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookThumbMore extends StatelessWidget {
  final Function(String) onClick;
  ItemBookThumbMore({Key key, @required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onClick("data"),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
              width: 75.0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "More...",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              )),
        ));
  }
}
