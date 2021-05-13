import 'package:flutter/cupertino.dart';

class Sizes {
  double height(context, height) {
    return MediaQuery.of(context).size.height * (height/896);
  }

  double width(context, width) {
    return MediaQuery.of(context).size.width * (width/414);
  }
}