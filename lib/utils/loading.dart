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
      body: ListView(
        children: [
          Column(
            children: [
              Text(
                'kaze',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours().white(),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  letterSpacing: 6,
                  fontFamily: 'ProductSans'
                ),
              ),
              SizedBox(height: Sizes().height(context, 48),),

              SizedBox(
                width: Sizes().width(context, 414),
                height: Sizes().height(context, 550),
                child: Image(
                  image: AssetImage('assets/loading.png'),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: Sizes().height(context, 32),),

              Container(
                width: Sizes().width(context, 375),
                height: Sizes().height(context, 110),
                color: Colours().white(),
                child: Center(
                  child: Text(
                    'Loading...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colours().black(),
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        fontFamily: 'ProductSans',
                      shadows: [
                        Shadow(
                          offset: Offset(16, 32),
                          blurRadius: 64.0,
                          color: Colours().black(opacity: .2)
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
