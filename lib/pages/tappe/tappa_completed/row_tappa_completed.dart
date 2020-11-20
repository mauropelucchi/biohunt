import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';
import 'package:biohunt/utils/date_util.dart';
import 'package:biohunt/utils/app_constant.dart';
import 'package:biohunt/pages/tappe/row_tappa.dart';

class TappaCompletedRow extends StatelessWidget {
  final Tappe tappe;
  final List<String> labelNames = List();

  TappaCompletedRow(this.tappe);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTappe(tappa: tappe),
          ),
        )
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: PADDING_TINY),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 4.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(PADDING_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: ListTile(
                        leading: (tappe.lastTappa)
                            ? Icon(Icons.tour)
                            : Icon(Icons.place),
                        title: (Text(tappe.title,
                            key: ValueKey("tappa_completed_${tappe.id}"),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: FONT_SIZE_TITLE,
                                fontWeight: FontWeight.bold)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: Row(
                      children: <Widget>[
                        Text(
                          getFormattedId(tappe.id),
                          style: TextStyle(
                              color: Colors.grey, fontSize: FONT_SIZE_DATE),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(tappe.percorsoName,
                                      style: TextStyle(
                                          color: Color(tappe.percorsoColor),
                                          fontSize: FONT_SIZE_LABEL)),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    width: 8.0,
                                    height: 8.0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color(tappe.percorsoColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
