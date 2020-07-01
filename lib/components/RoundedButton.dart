import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.label, this.colour, @required this.whenPressed});
  final String label;
  final Color colour;
  final Function whenPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: whenPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,style:TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}