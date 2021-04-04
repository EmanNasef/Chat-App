import 'package:flutter/material.dart';

const textFieldDecoration=  InputDecoration(
  hintText: '',
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0))),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.green, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.green, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),);

const textStyle = TextStyle(
    fontSize: 30.0, color: Colors.black87, fontFamily: 'Pacifico');