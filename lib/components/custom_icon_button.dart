import 'package:flutter/material.dart';

class CutomIconButton extends StatelessWidget {
  IconData icons;
  Color colors;
  Function onPress;
  CutomIconButton({@required icons, this.colors, this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icons),
      highlightColor: colors,
      onPressed: onPress,
    );
  }
}
