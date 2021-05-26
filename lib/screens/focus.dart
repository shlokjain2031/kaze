import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaze/screens/settings.dart';
import 'package:kaze/services/focus.dart';
import 'package:kaze/services/settings.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

import 'home.dart';

class FocusMode extends StatelessWidget {
  List focusModeApps;

  Sizes sizes = Sizes();
  Colours colours = Colours();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
          backgroundColor: colours.black(),
          body: FutureBuilder(
            future: FocusModeService().getApps(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                focusModeApps = snapshot.data;
                return FutureBuilder(
                  future: FocusModeService().getFocusWallpaper(),
                  builder: (context, wallpaperSnapshot) {
                    return wallpaperSnapshot.data != null ? Container(
                        width: sizes.width(context, 414),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(wallpaperSnapshot.data)),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(colours.black().withOpacity(0.7),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 36),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Focus Mode',
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        fontSize: 64,
                                        color: colours.white(),
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              offset: Offset(8,8),
                                              color: colours.black(opacity: .65),
                                              blurRadius: 48
                                          )
                                        ]
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: sizes.height(context, 250), left: sizes.width(context, 125)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Util().launchApp(focusModeApps[0]["package"]);
                                        },
                                        child: Container(
                                          width: sizes.width(context, 72),
                                          height: sizes.height(context, 80),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: colours.white(), width: 3),
                                              color: colours.white(),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(8, 16),
                                                    color: colours.black(opacity: .2),
                                                    blurRadius: 64
                                                )
                                              ]
                                          ),
                                          child: Image(
                                            image: MemoryImage(focusModeApps[0]["icon"]),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 24,),
                                      GestureDetector(
                                        onTap: () {
                                          Util().launchApp(focusModeApps[1]["package"]);
                                        },
                                        child: Container(
                                          width: sizes.width(context, 72),
                                          height: sizes.height(context, 80),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: colours.white(), width: 3),
                                              color: colours.white(),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(8, 16),
                                                    color: colours.black(opacity: .2),
                                                    blurRadius: 64
                                                )
                                              ]
                                          ),
                                          child: Image(
                                            image: MemoryImage(focusModeApps[1]["icon"]),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: sizes.height(context, 830), left: 18, right: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Util().getCurrentTime(),
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: colours.white(opacity: .6),
                                        shadows: [
                                          Shadow(
                                              offset: Offset(8,8),
                                              color: colours.black(opacity: .4),
                                              blurRadius: 64
                                          )
                                        ]
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      CustomDialogs().areYouSureFocus(context, sizes, colours);
                                    },
                                    child: Text(
                                      'exit',
                                      style: TextStyle(
                                          fontFamily: 'ProductSans',
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: colours.white(),
                                          shadows: [
                                            Shadow(
                                                offset: Offset(8,8),
                                                color: colours.black(opacity: .2),
                                                blurRadius: 64
                                            )
                                          ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ) : Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 28),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Focus Mode',
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 64,
                                    color: colours.white(),
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(8,8),
                                          color: colours.black(opacity: .65),
                                          blurRadius: 32
                                      )
                                    ]
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: sizes.height(context, 250), left: sizes.width(context, 125)),
                              child: FutureBuilder(
                                  future: FocusModeService().getApps(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      List<Map> apps = snapshot.data;
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: sizes.width(context, 72),
                                            height: sizes.height(context, 80),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: colours.white(), width: 3),
                                                color: colours.white(),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(8, 16),
                                                      color: colours.black(opacity: .2),
                                                      blurRadius: 64
                                                  )
                                                ]
                                            ),
                                            child: Image(
                                              image: MemoryImage(apps[0]["icon"]),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          SizedBox(width: 24,),
                                          Container(
                                            width: sizes.width(context, 72),
                                            height: sizes.height(context, 80),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: colours.white(), width: 3),
                                                color: colours.white(),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(8, 16),
                                                      color: colours.black(opacity: .2),
                                                      blurRadius: 64
                                                  )
                                                ]
                                            ),
                                            child: Image(
                                              image: MemoryImage(apps[1]["icon"]),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      return SizedBox();
                                    }
                                  }
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: sizes.height(context, 830), left: 18, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Util().getCurrentTime(),
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: colours.white(opacity: .6),
                                    shadows: [
                                      Shadow(
                                          offset: Offset(8,8),
                                          color: colours.black(opacity: .4),
                                          blurRadius: 64
                                      )
                                    ]
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  CustomDialogs().areYouSureFocus(context, sizes, colours);
                                },
                                child: Text(
                                  'exit',
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: colours.white(),
                                      shadows: [
                                        Shadow(
                                            offset: Offset(8,8),
                                            color: colours.black(opacity: .2),
                                            blurRadius: 64
                                        )
                                      ]
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              }
              else {
                return Column(
                  children: [
                    SizedBox(height: sizes.height(context, 200),),
                    Text(
                      'No apps in\nFocus Mode',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 54,
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
                                padding: EdgeInsets.only(top: 12),
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
                                padding: EdgeInsets.only(top: 12),
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
                );
              }
            },
          ),
      ),
    );
  }
}
