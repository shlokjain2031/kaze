import 'package:flutter/material.dart';
import 'package:kaze/screens/settings.dart';

import 'colours.dart';
import 'sizes.dart';

class CustomDialogs {
  void category(context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 375),
            height: sizes.height(context, 275),
            decoration: BoxDecoration(
              color: colours.white(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Settings();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: 'ProductSans',
                            color: colours.black(),
                            decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: colours.black(),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Focus Mode',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: 'ProductSans',
                            color: colours.black(),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 32,
                        color: colours.black(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Shutdown',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: 'ProductSans',
                            color: colours.black(),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 32,
                        color: colours.black(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}