import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  // final OnPrese
  final bool isWithArrow;
  final double drawablePaddingLeft;
  final GestureTapCallback onPressed;

  InputButton(
      {this.isWithArrow = false,
      this.drawablePaddingLeft = 0.0,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: drawablePaddingLeft),
                child: isWithArrow ? Text("->") : null,
              )
            ],
          )),
    );
  }
}
