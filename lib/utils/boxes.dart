import 'package:flutter/material.dart';

import 'colours.dart';
import 'sizes.dart';

class tickBox extends StatelessWidget {
  const tickBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes().width(context, 28),
      height: Sizes().height(context, 32),
      color: Colours().white(),
      child: Center(
        child: Icon(
          Icons.done,
          size: Sizes().width(context, 18),
          color: Colours().black(),
        ),
      ),
    );
  }
}

class blankBox extends StatelessWidget {
  const blankBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes().width(context, 28),
      height: Sizes().height(context, 32),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colours().white(opacity: .7), width: 2)
      ),
    );
  }
}