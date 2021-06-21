import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/bottom_sheet.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

import 'add.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Sizes sizes = Sizes();
  Colours colours = Colours();
  PageController _pageController = PageController(initialPage: 1, viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        backgroundColor: colours.black(),
        body: FutureBuilder<ModeModel>(
          future: ModeService().getCurrentMode(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              ModeModel currentMode = snapshot.data;
              List apps = Util().listParser(currentMode.apps);
              String currentFormattedDate = Util().getCurrentFormattedDate();

              return Container(
                decoration: BoxDecoration(
                  image: currentMode.wallpaperPath != null ? DecorationImage(
                    image: FileImage(File(currentMode.wallpaperPath)),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(colours.black().withOpacity(0.7),
                        BlendMode.dstATop),
                  ) : null
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
                      currentMode.title,
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

                    SizedBox(
                      height: sizes.height(context, 600),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sensitivity = 15;
                        if (details.delta.dy < -sensitivity) {
                          BottomSheets().allAppsBottomSheet(context, sizes, colours, currentMode);
                        }
                      },
                      child: Column(
                        children: [
                          Center(
                            child: Image(
                              image: AssetImage('assets/arrow.png'),
                              color: colours.white(),
                              width: sizes.width(context, 32),
                            ),
                          ),
                          SizedBox(height: sizes.height(context, 8),),
                          SizedBox(
                            width: sizes.width(context, 400),
                            height: sizes.height(context, 60),
                            child: ListView.builder(
                              itemCount: apps.length < 5 ? apps.length : 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Util().openApp(apps[index]["package"]);
                                  },
                                  child: Container(
                                    width: sizes.width(context, 60),
                                    height: sizes.height(context, 60),
                                    margin: EdgeInsets.only(left: sizes.width(context, 20)),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(8, 16),
                                              color: colours.black(opacity: .2),
                                              blurRadius: 64
                                          )
                                        ]
                                    ),
                                    child: Image(
                                      image: MemoryImage(Util().getAppIcon(apps[index]["icon"])),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            else {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TitleAdd();
                      },
                    ),
                  );
                  FirebaseAnalytics().logEvent(name: "click_on_add_mode");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colours.black(),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'mode',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(opacity: .9)
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                CustomDialogs().category(context, sizes, colours);
                              },
                              child: Image(
                                image: AssetImage('assets/category.png'),
                                width: 36,
                                color: colours.white(),
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: sizes.height(context, 200)),
                      Text(
                        "Add +",
                        style: TextStyle(
                            fontSize: 54,
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                            color: colours.white(opacity: .9),
                            shadows: [
                              Shadow(
                                  offset: Offset(8, 8),
                                  blurRadius: 32,
                                  color: colours.black(opacity: .6)
                              )
                            ]
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'click to add a mode',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'ProductSans',
                          color: colours.white(opacity: .8),
                        ),
                      ),
                      SizedBox(height: sizes.height(context, 48)),
                    ],
                  ),
                ),
              );
            }
          }
        ),
      ),
    );
  }
}


