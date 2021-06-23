import 'package:flutter/material.dart';
import 'package:kaze/services/apps.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

class ExitApp extends StatelessWidget {
  ExitApp({Key key}) : super(key: key);

  Colours colours = Colours();
  Sizes sizes = Sizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: Column(
        children: [
          Container(
            width: sizes.width(context, 414),
            height: sizes.height(context, 500),
            margin: EdgeInsets.only(top: 32),
            child: Image(
              image: AssetImage('assets/exit_app.gif'),
            ),
          ),
          SizedBox(height: 32),
          Text(
              "follow this to exit kaze",
              style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: colours.white()
              )
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "this is a two-step process to ensure that your phone is safe and secured even after kaze is not your primary launcher",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 15,
                    color: colours.white().withOpacity(.8)
                )
            ),
          ),

          SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              AppsService().openSettings("com.kaze.kaze");
            },
            child: Container(
              width: sizes.width(context, 325),
              height: 64,
              decoration: BoxDecoration(
                  color: colours.white(),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(8, 16),
                        color: colours.white(opacity: .1),
                        blurRadius: 32
                    )
                  ]
              ),
              child: Center(
                child: Text(
                  "open kaze's settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProductSans'
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
