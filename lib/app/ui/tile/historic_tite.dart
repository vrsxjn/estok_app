import 'package:app_flutter/app/entities/historic_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoricTite extends StatelessWidget {
  final HistoricDb historic;

  HistoricTite(this.historic);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 0,
          right: 0,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.historic.att,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF58355E),
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${this.historic.type}',
                          style:
                              TextStyle(fontSize: 10, color: Color(0xFF949191)),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text("${this.historic.date}",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF58355E),
                          )),
                      Text(
                        "${this.historic.hour}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ));
  }
}
