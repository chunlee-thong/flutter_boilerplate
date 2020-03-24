import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle title = TextStyle(fontSize: 16, color: Colors.white);

RoundedRectangleBorder roundRect([double radius = 8]) {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}
