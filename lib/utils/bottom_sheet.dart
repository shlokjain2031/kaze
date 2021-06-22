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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: sizes.width(context, 32),
                            color: colours.white(),
                          ),
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
                        GestureDetector(
                          onTap: () {
                            CustomDialogs().category(context, sizes, colours, title: currentMode.title);
                          },
                          child: Image(
                            image: AssetImage('assets/more.png'),
                            width: sizes.width(context, 36),
                            color: colours.white(),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 32)),

                  // todo: perf
                  FutureBuilder(
                      future: Util().getAllApps(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          EasyLoading.dismiss();
                          List installedApps = Util().convertListApplicationWithIconToListMap(snapshot.data);
                          List modeApps = Util().listDecoder(currentMode.apps);

                          return SizedBox(
                            height: Sizes().height(context, 790),
                            width: Sizes().width(context, 414),
                            child: GridView.count(
                              crossAxisCount: 5,
                              mainAxisSpacing: 24,
                              physics: BouncingScrollPhysics(),
                              children: List.generate(
                                installedApps != null ? installedApps.length : 0, (index) {
                                  bool isAppInMode = Util().checkIfAppIsInMode(modeApps, installedApps, index);

                                  return GestureDetector(
                                    onTap: () {
                                      if(isAppInMode) {
                                        Util().openApp(installedApps[index]["package"]);
                                      }
                                      else {
                                        CustomDialogs().openApp(context, Sizes(), Colours(), installedApps[index]);
                                      }
                                      FirebaseAnalytics().logEvent(name: "click_on_launch_app_all_apps");
                                    },
                                    onLongPress: () {
                                      if(isAppInMode) {
                                        Util().openSettings(installedApps[index]["package"]);
                                      }
                                    },
                                    child: Container(
                                      width: sizes.width(context, 54),
                                      height: sizes.height(context, 74),
                                      margin: EdgeInsets.only(left: 20, right: 20),
                                      child: Column(
                                        children: [
                                          ColorFiltered(
                                            colorFilter: !isAppInMode ? ColorFilter.matrix(<double>[
                                              0.2126,0.7152,0.0722,0,0,
                                              0.2126,0.7152,0.0722,0,0,
                                              0.2126,0.7152,0.0722,0,0,
                                              0,0,0,1,0,
                                            ]) : ColorFilter.mode(colours.black(opacity: 1.0),
                                                BlendMode.dstATop),
                                            child: Image(
                                              image: MemoryImage(installedApps[index]["icon"]),
                                              width: sizes.width(context, 54),
                                              height: sizes.height(context, 54),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            installedApps[index]["label"],
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