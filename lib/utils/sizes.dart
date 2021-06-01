import 'package:flutter/cupertino.dart';

class Sizes {
  double height(context, height, {parent=896}) {
    return MediaQuery.of(context).size.height * (height/parent);
  }

  double width(context, width, {parent=414}) {
    return MediaQuery.of(context).size.width * (width/parent);
  }
}