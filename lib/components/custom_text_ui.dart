import 'package:flutter/material.dart';

class CustomTextUi extends StatelessWidget {
  String labelText;
  String fonte;
  double fonteSize;
  int maxLine;
  bool softWrap;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextAlign textAlign;
  Color color;

  CustomTextUi(
      {@required this.labelText,
      this.fonte,
      this.fonteSize,
      this.maxLine,
      this.softWrap,
      this.overflow,
      this.fontWeight = FontWeight.w400,
      this.textAlign,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TextStyle(
          fontFamily: fonte,
          fontSize: fonteSize,
          color: color,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
    );
  }
}
