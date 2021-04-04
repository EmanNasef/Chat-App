import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPress;

  CustomButton({this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.green,
      elevation: 5.0,
      child: MaterialButton(
        minWidth: 200.0,
        height: 50.0,
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 25.0, color: Colors.black87, fontFamily: 'Pacifico'),
        ),
      ),
    );
  }
}
