// ignore_for_file: duplicate_import, prefer_const_constructors, unnecessary_this, sized_box_for_whitespace, unused_import

import 'package:first_app/utils/kvStore.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/utils/kvStore.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final String routeName;

  const HomeCard({Key? key, required this.text, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              height: 60.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 179, 177, 177),
                          width: 1.5))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 285,
                      child: Text(
                        this.text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 35,
                      color: Colors.white,
                    )
                  ]),
            ),
            onTap: () {
              print("click --" + text.toString() + "-- home 名称");
              //print("click --" + functionCode.toString() + "-- 页面code");
              //kvStore.save("functionCode", functionCode);
              Navigator.pushNamed(context, this.routeName,
                  arguments: text.toString());
            },
          ),
        ),
      ],
    );
  }
}
