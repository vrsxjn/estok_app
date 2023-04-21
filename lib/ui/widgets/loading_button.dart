import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  String title;
  Function onPressed;
  bool isLoading;
  double height;
  double width;
  Color colorButton;
  Color colorTextButton;
  double heightCircle;
  double widthCircle;
  double strokeWidht;
  double fonteSize;
  Color colorCircularProgess;
  double borderRadius;

  LoadingButton({
    @required this.title,
    this.onPressed,
    this.isLoading = false,
    this.height = 45.0,
    this.width = double.infinity,
    this.colorButton,
    this.colorTextButton = Colors.black,
    this.heightCircle = 20.0,
    this.widthCircle = 20.0,
    this.fonteSize = 16,
    this.strokeWidht = 3.0,
    this.colorCircularProgess,
    this.borderRadius = 17,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: !isLoading
            ? Text(title)
            : Container(
                width: widthCircle,
                height: heightCircle,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      colorCircularProgess ?? Theme.of(context).primaryColor),
                  strokeWidth: strokeWidht,
                ),
              ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: fonteSize,
          ),
          primary: colorButton,
          onPrimary: colorTextButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
