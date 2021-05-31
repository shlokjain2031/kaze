import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours().black(),
      body: Column(
        children: [
          Text(
            'kaze',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colours().white(),
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 2
            ),
          ),
          SizedBox(height: Sizes().height(context, 64),),

          SizedBox(
            width: Sizes().width(context, 414),
            height: Sizes().height(context, 414),
            child: Image(
              image: AssetImage('assets/loading.png'),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: Sizes().height(context, 48),),

          Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colours().white(),
                fontWeight: FontWeight.bold,
                fontSize: 72,
            ),
          ),
        ],
      ),
    );
  }
}
