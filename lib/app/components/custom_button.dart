import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String labelText;
  double height;
  double widght;
  double fonteSize;
  Function onpress;
  Color textColor;
  Color color;

  CustomButton(
      {@required this.labelText,
      this.height,
      this.widght,
      this.textColor,
      this.onpress,
      this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: height,
      minWidth: widght,
      color: color,
      textColor: textColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      onPressed: onpress,
      child: Text(labelText),
    );
  }
}
