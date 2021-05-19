import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kaze/services/focus.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

class FocusMode extends StatelessWidget {
  FocusMode({Key key}) : super(key: key);

  Sizes sizes = Sizes();
  Colours colours = Colours();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: FutureBuilder<String>(
        future: FocusModeService().getWallpaper(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Container(
              width: sizes.width(context, 414),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(snapshot.data)),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(colours.black().withOpacity(0.65),
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
                                    GestureDetector(
                                      onTap: () {
                                        Util().launchApp(apps[0]["package"]);
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
                                          image: MemoryImage(apps[0]["icon"]),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 24,),
                                    GestureDetector(
                                      onTap: () {
                                        Util().launchApp(apps[1]["package"]);
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
                                          image: MemoryImage(apps[1]["icon"]),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              else {
                                print("ueloo");
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
                        Text(
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          else {
            return Stack(
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

                    FutureBuilder(
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
                            print("ueloo");
                            return SizedBox();
                          }
                        }
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
                      Text(
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
                      )
                    ],
                  ),
                )
              ],
            );
          }
        }
      ),
    );
  }
}
