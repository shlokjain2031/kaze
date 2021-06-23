import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/screens/settings.dart';
import 'package:kaze/services/apps.dart';
import 'package:kaze/services/focus.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

import 'home.dart';

class FocusMode extends StatefulWidget {
  @override
  _FocusModeState createState() => _FocusModeState();
}

class _FocusModeState extends State<FocusMode> {
  List focusModeApps;

  Sizes sizes = Sizes();
  Colours colours = Colours();

  @override
  void initState() {
    Util().setDndFilter(dnd: 3);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: FutureBuilder(
        future: FocusModeService().checkForFocusModeApps(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data) {
              return FutureBuilder(
                future: FocusModeService().getFocusModeApps(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    EasyLoading.dismiss();
                    focusModeApps = snapshot.data;

                    return FutureBuilder(
                      future: FocusModeService().getFocusWallpaper(),
                      builder: (context, wallpaperSnapshot) {
                        String currentFormattedDate = Util()
                            .getCurrentFormattedDate();

                        return Scaffold(
                            backgroundColor: colours.black(),
                            body: Container(
                              width: sizes.width(context, 414),
                              decoration: BoxDecoration(
                                image: wallpaperSnapshot.data != null
                                    ? DecorationImage(
                                  image: FileImage(
                                      File(wallpaperSnapshot.data)),
                                  fit: BoxFit.fitHeight,
                                  colorFilter: ColorFilter.mode(
                                      colours.black().withOpacity(0.7),
                                      BlendMode.dstATop),
                                )
                                    : BoxDecoration(color: colours.black()),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: sizes.height(context, 32),),
                                  Text(
                                    currentFormattedDate,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colours.white(opacity: .8),
                                      fontSize: 28,
                                      fontFamily: 'ProductSans',
                                    ),
                                  ),

                                  SizedBox(height: sizes.height(context, 20),),
                                  Text(
                                    'Focus Mode',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: colours.white(),
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ProductSans',
                                        shadows: [
                                          Shadow(
                                            offset: Offset(8, 8),
                                            color: colours.black(opacity: .35),
                                            blurRadius: 32.0,
                                          )
                                        ]
                                    ),
                                  ),
                                  SizedBox(height: sizes.height(context, 20),),
                                  GestureDetector(
                                    onTap: () {
                                      CustomDialogs().areYouSureFocus(context, sizes, colours);
                                    },
                                    child: Container(
                                      width: sizes.width(context, 210),
                                      height: sizes.height(context, 72),
                                      decoration: BoxDecoration(
                                        color: colours.white(),
                                        border: Border.all(color: colours.black(), width: 3)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'exit focus mode',
                                          style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            fontSize: 22,
                                            color: colours.black(),
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: sizes.height(context, 540),
                                  ),
                                  SizedBox(height: sizes.height(context, 8),),
                                  SizedBox(
                                    width: sizes.width(context, 400),
                                    height: sizes.height(context, 60),
                                    child: ListView.builder(
                                        itemCount: focusModeApps.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              AppsService().openApp(focusModeApps[index]["package"]);
                                            },
                                            child: Container(
                                              width: sizes.width(context, 60),
                                              height: sizes.height(context, 60),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.25),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(8, 16),
                                                        color: colours.black(
                                                            opacity: .2),
                                                        blurRadius: 64
                                                    )
                                                  ]
                                              ),
                                              child: Image(
                                                image: MemoryImage(
                                                    AppsService().getAppIcon(focusModeApps[index]["icon"])),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                    );
                  }
                  else {
                    EasyLoading.show(status: "loading");
                    return SizedBox();
                  }
                },
              );
            }
            else {
              return Scaffold(
                backgroundColor: colours.black(),
                body: Column(
                  children: [
                    SizedBox(height: sizes.height(context, 200),),
                    Text(
                      'Have you added apps\nin Focus Mode?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: colours.white(),
                          fontFamily: 'ProductSans'
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 100),),
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return FocusModeSettings();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: sizes.width(context, 150),
                                height: sizes.height(context, 80),
                                padding: EdgeInsets.only(top: sizes.height(context, 24)),
                                decoration: BoxDecoration(
                                    color: colours.white(),
                                    border: Border.all(color: colours.black(), width: 2)
                                ),
                                child: Text(
                                  'add apps',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colours.black(),
                                      decoration: TextDecoration.none
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6,),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: sizes.width(context, 120),
                                height: sizes.height(context, 80),
                                padding: EdgeInsets.only(top: sizes.height(context, 24)),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: colours.white(), width: 2)
                                ),
                                child: Text(
                                  'go back',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colours.white(),
                                      decoration: TextDecoration.none
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          else {
            EasyLoading.show(status: "loading");
            return SizedBox();
          }
        }
      ),
    );
  }
}
