import 'package:flutter/material.dart';

void main() {
  runApp(Kaze());
}

class Kaze extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaze',
      home: HelloThere(),
    );
  }
}

class HelloThere extends StatelessWidget {
  const HelloThere({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Hello There'
      ),
    );
  }
}

