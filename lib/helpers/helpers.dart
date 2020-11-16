import 'package:flutter/material.dart';

class Functions {
  static Widget button_defined(text, Function callback, IconData icon) {
    return FlatButton.icon(
      color: Colors.blue[50],
      onPressed: callback,
      icon: Icon(icon),
      label: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blue)),
    );
  }
}
