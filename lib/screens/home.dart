import 'package:flutter/material.dart';

import 'add.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Add();
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 48),
          color: Colors.lightBlue,
          child: Text('home'),
        ),
      ),
    );
  }
}
