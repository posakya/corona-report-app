import 'package:flutter/material.dart';


class Protect{
  String _title;
  Widget _emoji;

  set emoji(Widget value) {
    _emoji = value;
  }

  Widget get emoji => _emoji;

  String get title => _title;

  set title(String value) {
    _title = value;
  }
  Protect();
}



