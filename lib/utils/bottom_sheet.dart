import 'dart:typed_data';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

import 'dialogs.dart';

class BottomSheets {
  void allAppsBottomSheet(context, Sizes sizes, Colours colours, ModeModel currentMode) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder){
          return Container(
            height: sizes.height(context, 896),
            color: Colors.transparent,
            child: Container(
              height: sizes.height(context, 896),
              color: colours.black(),
              child: Column(
                children: [
                  SizedBox(height: sizes.height(context, 28)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: sizes.width(context, 32),
                          color: colours.white(),
                        ),
                        Text(
                          'ALL APPS',
                          style: TextStyle(
                            fontSize: 18,
                            color: colours.white(),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/more.png'),
                          width: sizes.width(context, 36),
                          color: colours.white(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 27)),

                  FutureBuilder(
                      future: Util().getAllApps(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          EasyLoading.dismiss();
                          List installedApps = snapshot.data;
                          List modeApps = Util().listParser(currentMode.apps);

                          return SizedBox(
                            height: Sizes().height(context, 800),
                            width: Sizes().width(context, 414),
                            child: GridView.count(
                              crossAxisCount: 5,
                              mainAxisSpacing: 24,
                              physics: BouncingScrollPhysics(),
                              children: List.generate(
                                installedApps != null ? installedApps.length : 0, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      CustomDialogs().openApp(context, Sizes(), Colours(), Util().convertApplicationWithIconToMap(installedApps[index]));
                                      FirebaseAnalytics().logEvent(name: "click_on_launch_app_all_apps");
                                    },
                                    onLongPress: () {
                                      Util().openSettings(installedApps[index].packageName);
                                    },
                                    child: Container(
                                      width: sizes.width(context, 54),
                                      height: sizes.height(context, 74),
                                      margin: EdgeInsets.only(left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          ColorFiltered(
                                            colorFilter: Util().checkIfAppIsInMode(modeApps, installedApps) ?  ColorFilter.matrix(<double>[
                                                0.2126,0.7152,0.0722,0,0,
                                                0.2126,0.7152,0.0722,0,0,
                                                0.2126,0.7152,0.0722,0,0,
                                                0,0,0,1,0,
                                              ]),
                                            child: Image(
                                              image: MemoryImage(installedApps[index].icon),
                                              width: sizes.width(context, 54),
                                              height: sizes.height(context, 54),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            installedApps[index].appName,
                                            style: TextStyle(
                                              color: Colours().white(),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              fontFamily: 'ProductSans'
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        else {
                          EasyLoading.show(status: 'loading...');
                          return SizedBox();
                        }
                      }
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  iconContainer(index, installedApps) {
    try {
      return ;
    } catch (e) {
      return Container();
    }
  }
}