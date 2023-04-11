import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  String message;
  double fontSize;
  double fontWeight;
  Color color;

  Message({this.message, this.fontSize, this.fontWeight, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: fontSize ?? 15,
          fontFamily: 'Montserrat',
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? Colors.grey[600],
        ),
      ),
    );
  }

  static void onSuccess(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required String message,
      int seconds,
      Function onPop}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Color(0xFF58355E),
      duration: Duration(seconds: seconds ?? 3),
    ));
    if (onPop != null) {
      Future.delayed(Duration(seconds: seconds ?? 3)).then(onPop);
    }
  }

  static void onFail({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required String message,
    int seconds,
    Function onPop,
  }) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[800],
      duration: Duration(seconds: seconds ?? 3),
    ));
    if (onPop != null) {
      Future.delayed(Duration(seconds: seconds ?? 3)).then(onPop);
    }
  }

  static Widget loading(
    BuildContext context, {
    double width,
    double height,
    double strokeWidth,
    @required Color color,
  }) {
    return Center(
      child: Container(
        width: width ?? 40.0,
        height: height ?? 40.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Color(0xFF58355E)),
          strokeWidth: strokeWidth ?? 5.0,
        ),
      ),
    );
  }

  static void alertDialog(
    BuildContext context, {
    String title = "",
    String subtitle = "",
    @required String textokButton,
    @required Function onPressOkbutton,
    String textNoButton = "No",
    Function onPressedNoButton,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              actions: [
                onPressedNoButton == null
                    ? Container()
                    : FlatButton(
                        onPressed: onPressedNoButton,
                        child: Text(
                          textNoButton,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800),
                        )),
                FlatButton(
                  onPressed: onPressOkbutton,
                  child: Text(
                    textokButton,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800),
                  ),
                )
              ],
            ),
          );
        });
  }
}
