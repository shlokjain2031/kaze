import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/settings.dart';
import 'package:kaze/services/user.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/circle.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

import 'add.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  Sizes sizes = Sizes();
  Colours colours = Colours();

  Map onboardingElements = {
    "image": "assets/focus.png",
    "title": "focus mode",
    "desc": "to help you maintain your daily\nscreentime on certain apps"
  };
  int onboardingTracker = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: getOnboarding(),
    );
  }

  getOnboarding() {
    Widget onboarding;
    switch(onboardingTracker) {
      case 0:
        onboarding = Column(
          children: [
            Container(
              width: sizes.width(context, 414),
              height: sizes.height(context, 500),
              margin: EdgeInsets.only(top: 32),
              child: Image(
                image: AssetImage('assets/focus.png'),
              ),
            ),
            Text(
                "focus mode",
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colours.white()
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                  "to help you maintain your daily\nscreentime on certain apps",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18,
                      color: colours.white().withOpacity(.8)
                  )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 54),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: sizes.width(context, 140),
                      height: sizes.height(context, 140),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: colours.white().withOpacity(.5), width: 3.5)
                      ),
                    ),
                  ),

                  Center(
                    child: MyArc(diameter: sizes.width(context, 110), piMultiplier: (1/2),)
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          print("hello");
                          setState(() {
                            onboardingTracker = 1;
                          });
                        },
                        child: Container(
                          width: sizes.width(context, 100),
                          height: sizes.height(context, 100),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colours.white()
                          ),
                          child: Center(
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: colours.black(),
                                size: sizes.height(context, 48),
                              )
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case 1:
        onboarding = Column(
          children: [
            Container(
              width: sizes.width(context, 414),
              height: sizes.height(context, 500),
              margin: EdgeInsets.only(top: 32),
              child: Image(
                image: AssetImage('assets/time.png'),
              ),
            ),
            Text(
                "use apps on time",
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colours.white()
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                  "using apps only during\nthe allotted time slot for it",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18,
                      color: colours.white().withOpacity(.8)
                  )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 54),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: sizes.width(context, 140),
                      height: sizes.height(context, 140),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: colours.white().withOpacity(.5), width: 3.5)
                      ),
                    ),
                  ),

                  Center(
                      child: MyArc(diameter: sizes.width(context, 110), piMultiplier: 1,)
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onboardingTracker = 2;
                          });
                        },
                        child: Container(
                          width: sizes.width(context, 100),
                          height: sizes.height(context, 100),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colours.white()
                          ),
                          child: Center(
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: colours.black(),
                                size: sizes.height(context, 48),
                              )
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case 2:
        onboarding = Column(
          children: [
            Container(
              width: sizes.width(context, 414),
              height: sizes.height(context, 500),
              margin: EdgeInsets.only(top: 32),
              child: Image(
                image: AssetImage('assets/shutdown.png'),
              ),
            ),
            Text(
                "total shutdown",
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colours.white()
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                  "a mode where you can forget your\nphone even exists, used to concentrate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18,
                      color: colours.white().withOpacity(.8)
                  )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 54),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: sizes.width(context, 140),
                      height: sizes.height(context, 140),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: colours.white().withOpacity(.5), width: 3.5)
                      ),
                    ),
                  ),

                  Center(
                      child: MyArc(diameter: sizes.width(context, 110), piMultiplier: (3/2),)
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          // Util().notificationPolicyAccessCheck();
                          Util().displayDefaultLauncherChooser();
                          setState(() {
                            onboardingTracker = 3;
                          });
                        },
                        child: Container(
                          width: sizes.width(context, 100),
                          height: sizes.height(context, 100),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colours.white()
                          ),
                          child: Center(
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: colours.black(),
                                size: sizes.height(context, 48),
                              )
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case 3:
        onboarding = Column(
          children: [
            Container(
              width: sizes.width(context, 414),
              height: sizes.height(context, 500),
              margin: EdgeInsets.only(top: 32),
              child: Image(
                image: AssetImage('assets/dnd.jpeg'),
              ),
            ),
            Text(
                "turn on dnd access",
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colours.white()
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                  "continue and give us access to the\ndnd settings to help you focus more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18,
                      color: colours.white().withOpacity(.8)
                  )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 54),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: sizes.width(context, 140),
                      height: sizes.height(context, 140),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: colours.white().withOpacity(.5), width: 3.5)
                      ),
                    ),
                  ),

                  Center(
                      child: MyArc(diameter: sizes.width(context, 110), piMultiplier: 2,)
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          Util().notificationPolicyAccess();
                          Util().displayDefaultLauncherChooser();
                          initUser();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AddSplashScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: sizes.width(context, 100),
                          height: sizes.height(context, 100),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colours.white()
                          ),
                          child: Center(
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: colours.black(),
                                size: sizes.height(context, 48),
                              )
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
    }

    return onboarding;
  }

  void initUser() {
    User().setUser();
    ModeModelProvider().initDatabase();
    SettingsService().setSettings(true, false, false); // notif, phone, backup

    Util().checkNotificationPermission();
  }
}

class AddSplashScreen extends StatelessWidget {
  AddSplashScreen({Key key}) : super(key: key);

  Sizes sizes = Sizes();
  Colours colours = Colours();

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
              image: AssetImage('assets/add.png'),
            ),
          ),
          Text(
              "add a mode",
              style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: colours.white()
              )
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text(
              // todo: content
                "a mode is [descriptiob about mode]",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 18,
                    color: colours.white().withOpacity(.8)
                )
            ),
          ),
          SizedBox(height: 32,),

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TitleAdd();
                  },
                ),
              );
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
                  'click here to add a mode',
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

