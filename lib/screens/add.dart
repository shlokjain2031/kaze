import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/loading.dart' as loadingWidget;
import 'package:kaze/utils/sizes.dart';

import 'home.dart';

class TitleAdd extends StatefulWidget {
  const TitleAdd({Key key}) : super(key: key);

  @override
  _TitleAddState createState() => _TitleAddState();
}
class _TitleAddState extends State<TitleAdd> {
  Colours colours = Colours();
  Sizes sizes = Sizes();

  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 24,),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                      child: SizedBox(
                        width: sizes.width(context, 414),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (newTitle) {
                            title = newTitle;
                          },
                          onTap: () {
                            FirebaseAnalytics().logEvent(name: "added_title");
                          },
                          style: TextStyle(
                            color: colours.white(),
                            fontSize: 64,
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "Work",
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: colours.white().withOpacity(.7),
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProductSans',
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                    child: Divider(
                      height: sizes.height(context, 6),
                      thickness: 6,
                      color: colours.white().withOpacity(.7),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.only(top: sizes.height(context, 16)),
                    child: Text(
                      'give a name to your mode',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 20,
                          color: colours.white()
                      ),
                    ),
                  ),

                  SizedBox(
                    height: sizes.height(context, 440),
                  ),

                  SizedBox(
                    height: sizes.height(context, 60),
                  ),

                  SizedBox(height: sizes.height(context, 110)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: sizes.height(context, 800)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'back',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white().withOpacity(.7)
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AppsAdd(title);
                              },
                            ),
                          );
                          FirebaseAnalytics().logEvent(name: "went_to_ChooseApps");
                        },
                        child: Text(
                          'continue',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white()
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppsAdd extends StatefulWidget {
  String title;
  AppsAdd(this.title, {Key key}) : super(key: key);

  @override
  _AppsAddState createState() => _AppsAddState(title);
}
class _AppsAddState extends State<AppsAdd> {
  String title;
  _AppsAddState(this.title);

  Colours colours = Colours();
  Sizes sizes = Sizes();

  ValueNotifier<List<ApplicationWithIcon>> selectedApps = ValueNotifier([]);
  List allApps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: colours.white(),
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ProductSans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                    child: Divider(
                      height: sizes.height(context, 6),
                      thickness: 6,
                      color: colours.white(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: sizes.height(context, 16)),
                    child: Text(
                      'click the apps you will use in this mode',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 20,
                          color: colours.white()
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 175),),

                  ValueListenableBuilder(
                      valueListenable: selectedApps,
                      builder: (context, value, child) {
                        return Container(
                          margin: EdgeInsets.only(left: sizes.width(context, 42)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: sizes.width(context, 414),
                                height: sizes.height(context, 64),
                                child: ListView.builder(
                                  itemCount: selectedApps.value.length > 5 ? 5 : selectedApps.value.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, listIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedApps.value.removeAt(listIndex);
                                        selectedApps.notifyListeners();
                                        FirebaseAnalytics().logEvent(name: "removed_an_app");
                                      },
                                      child: Container(
                                        width: sizes.width(context, 50),
                                        height: sizes.height(context, 64),
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: colours.white(), width: 3),
                                          color: colours.white(), // change with colours.black(),
                                        ),
                                        child: Image(
                                          image: MemoryImage(selectedApps.value[listIndex].icon),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: sizes.height(context, 32)),
                              SizedBox(
                                width: sizes.width(context, 414),
                                height: sizes.height(context, 64),
                                child: ListView.builder(
                                  itemCount: selectedApps.value.length > 5 ? (selectedApps.value.length - 5) : 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, listIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedApps.value.removeAt(listIndex+5);
                                        selectedApps.notifyListeners();
                                      },
                                      child: Container(
                                        width: sizes.width(context, 50),
                                        height: sizes.height(context, 64),
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: colours.white(), width: 3),
                                            color: colours.white() // change with colours.black()
                                        ),
                                        child: Image(
                                          image: MemoryImage(selectedApps.value[(listIndex + 5)].icon),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),

                  SizedBox(
                    height: sizes.height(context, 200), // 180 for shlok
                  ),

                  Container(
                    width: sizes.width(context, 400),
                    height: sizes.height(context, 100),
                    child: FutureBuilder(
                        future: Util().getAllApps(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            List apps = snapshot.data;
                            allApps = apps;
                            return ListView.builder(
                              itemCount: apps.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                // Map dataObject = appList[index];
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: ValueListenableBuilder(
                                            valueListenable: selectedApps,
                                            builder: (context, value, child) {
                                              return GestureDetector(
                                                onTap: () {
                                                  bool duplicate = false;
                                                  for(int i=0;i<selectedApps.value.length;i++) {
                                                    if(selectedApps.value[i].packageName == apps[index].packageName) {
                                                      duplicate = true;
                                                      break;
                                                    }
                                                    else {
                                                      duplicate = false;
                                                    }
                                                  }

                                                  if(!duplicate) {
                                                    if(selectedApps.value.length <= 9) {
                                                      selectedApps.value.add(apps[index]);
                                                    }
                                                    else {
                                                      final duplicateOrExceedSnackBar = SnackBar(
                                                        content: Text(
                                                          "Only 10 apps are allowed in a single mode, click the app to remove it",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: colours.white(),
                                                              fontSize: 18,
                                                              fontFamily: 'ProductSans'
                                                          ),
                                                        ),
                                                        action: SnackBarAction(
                                                          label: 'Ok',
                                                          onPressed: () {},
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(context).showSnackBar(duplicateOrExceedSnackBar);
                                                    }
                                                  }
                                                  selectedApps.notifyListeners();
                                                  FirebaseAnalytics().logEvent(name: "selected_an_app");
                                                },
                                                child: Container(
                                                  width: sizes.width(context, 50),
                                                  height: sizes.height(context, 64),
                                                  margin: EdgeInsets.only(right: 8),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: colours.white(), width: 3),
                                                    color: colours.white(),
                                                  ),
                                                  child: Image(
                                                    image: MemoryImage(apps[index].icon),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          else {
                            return ListView.builder(
                              itemCount: 20,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                // Map dataObject = appList[index];
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Container(
                                          width: sizes.width(context, 50),
                                          height: sizes.height(context, 64),
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: colours.white(), width: 3),
                                            color: colours.white(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: sizes.height(context, 800)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          FirebaseAnalytics().logEvent(name: "went_back_to_title");
                        },
                        child: Text(
                          'back',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white().withOpacity(.7)
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TimeAdd(title, selectedApps, allApps);
                              },
                            ),
                          );
                          FirebaseAnalytics().logEvent(name: "went_to_TimeAdd");
                        },
                        child: Text(
                          'continue',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white()
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TimeAdd extends StatefulWidget {
  String title;
  ValueNotifier<List<ApplicationWithIcon>> selectedApps;
  List allApps;
  TimeAdd(this.title, this.selectedApps, this.allApps, {Key key}) : super(key: key);

  @override
  _TimeAddState createState() => _TimeAddState(title, selectedApps, allApps);
}
class _TimeAddState extends State<TimeAdd> {
  String title;
  ValueNotifier<List<ApplicationWithIcon>> selectedApps;
  List allApps;

  _TimeAddState(this.title, this.selectedApps, this.allApps);

  Colours colours = Colours();
  Sizes sizes = Sizes();

  TimeOfDay startTime = TimeOfDay(hour: 6, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: colours.white(),
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ProductSans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                    child: Divider(
                      height: sizes.height(context, 6),
                      thickness: 6,
                      color: colours.white(),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.only(top: sizes.height(context, 16)),
                    child: Text(
                      'add times when you will use these apps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 20,
                          color: colours.white()
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 175),),

                  ValueListenableBuilder(
                      valueListenable: selectedApps,
                      builder: (context, value, child) {
                        return Container(
                          margin: EdgeInsets.only(left: sizes.width(context, 42)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: sizes.width(context, 414),
                                height: sizes.height(context, 64),
                                child: ListView.builder(
                                  itemCount: selectedApps.value.length > 5 ? 5 : selectedApps.value.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, listIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedApps.value.removeAt(listIndex);
                                        selectedApps.notifyListeners();
                                      },
                                      child: Container(
                                        width: sizes.width(context, 50),
                                        height: sizes.height(context, 64),
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: colours.white(), width: 3),
                                          color: colours.white(), // change with colours.black(),
                                        ),
                                        child: Image(
                                          image: MemoryImage(selectedApps.value[listIndex].icon),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: sizes.height(context, 32)),
                              SizedBox(
                                width: sizes.width(context, 414),
                                height: sizes.height(context, 64),
                                child: ListView.builder(
                                  itemCount: selectedApps.value.length > 5 ? (selectedApps.value.length - 5) : 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, listIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedApps.value.removeAt(listIndex+5);
                                        selectedApps.notifyListeners();
                                      },
                                      child: Container(
                                        width: sizes.width(context, 50),
                                        height: sizes.height(context, 64),
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: colours.white(), width: 3),
                                            color: colours.white() // change with colours.black()
                                        ),
                                        child: Image(
                                          image: MemoryImage(selectedApps.value[(listIndex + 5)].icon),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),

                  SizedBox(height: sizes.height(context, 80)),

                  SizedBox(
                    width: sizes.width(context, 390),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _startTimePicker();
                              FirebaseAnalytics().logEvent(name: "clicked_startTime");
                            },
                            child: Stack(
                              children: [
                                Text(
                                  (startTime.hour < 10 ? "0" + startTime.hour.toString() : startTime.hour.toString()) + ":" + (startTime.minute == 0 ? startTime.minute.toString() + "0" : startTime.minute.toString()),
                                  style: TextStyle(
                                      color: colours.white(opacity: .1),
                                      fontFamily: 'ProductSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 64
                                  ),
                                ),
                                Container(
                                  width: sizes.width(context, 150),
                                  height: sizes.height(context, 54),
                                  margin: EdgeInsets.only(top: 48, left: 8),
                                  decoration: BoxDecoration(
                                      color: colours.white(),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8,),
                                      Image(
                                        image: AssetImage('assets/watch.png'),
                                        width: 24,
                                        color: colours.black(),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'start time',
                                        style: TextStyle(
                                          color: colours.black(),
                                          fontFamily: 'ProductSans',
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _endTimePicker();
                              FirebaseAnalytics().logEvent(name: "clicked_endTime");
                            },
                            child: Stack(
                              children: [
                                Text(
                                  (endTime.hour < 10 ? "0" + endTime.hour.toString() : endTime.hour.toString()) + ":" + (endTime.minute == 0 ? endTime.minute.toString() + "0" : endTime.minute.toString()),
                                  style: TextStyle(
                                      color: colours.white(opacity: .1),
                                      fontFamily: 'ProductSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 64
                                  ),
                                ),
                                Container(
                                  width: sizes.width(context, 150),
                                  height: sizes.height(context, 54),
                                  margin: EdgeInsets.only(top: 48, left: 8),
                                  decoration: BoxDecoration(
                                      color: colours.white(),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8,),
                                      Image(
                                        image: AssetImage('assets/watch.png'),
                                        width: 24,
                                        color: colours.black(),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'end time',
                                        style: TextStyle(
                                          color: colours.black(),
                                          fontFamily: 'ProductSans',
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: sizes.height(context, 24)),

                  Container(
                    width: sizes.width(context, 400),
                    height: sizes.height(context, 100),
                    child: ListView.builder(

                      itemCount: allApps.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        // Map dataObject = appList[index];
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: ValueListenableBuilder(
                                    valueListenable: selectedApps,
                                    builder: (context, value, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          bool duplicate = false;
                                          for(int i=0;i<selectedApps.value.length;i++) {
                                            if(selectedApps.value[i].packageName == allApps[index].packageName) {
                                              duplicate = true;
                                              break;
                                            }
                                            else {
                                              duplicate = false;
                                            }
                                          }
                                          if(!duplicate) {
                                            if(selectedApps.value.length <= 9) {
                                              selectedApps.value.add(allApps[index]);
                                            }
                                            else {
                                              final duplicateOrExceedSnackBar = SnackBar(
                                                content: Text(
                                                  "Only 10 apps are allowed in a single mode, click the app to remove it",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colours.white(),
                                                      fontSize: 18,
                                                      fontFamily: 'ProductSans'
                                                  ),
                                                ),
                                                action: SnackBarAction(
                                                  label: 'Ok',
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(duplicateOrExceedSnackBar);
                                            }
                                          }
                                          selectedApps.notifyListeners();
                                        },
                                        child: Container(
                                          width: sizes.width(context, 50),
                                          height: sizes.height(context, 64),
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: colours.white(), width: 3),
                                              color: colours.white() // change with colours.black()
                                          ),
                                          child: Image(
                                            image: MemoryImage(allApps[index].icon),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: sizes.height(context, 800)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          FirebaseAnalytics().logEvent(name: "went_back_to_ChooseApps");
                        },
                        child: Text(
                          'back',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white().withOpacity(.7)
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return FinalAdd(allApps: allApps, title: title, selectedApps: selectedApps, startTime: startTime, endTime: endTime);
                              },
                            ),
                          );
                          FirebaseAnalytics().logEvent(name: "went_to_FinalAdd");
                        },
                        child: Text(
                          'continue',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colours.white()
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _startTimePicker() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (newTime != null) {
      setState(() {
        startTime = newTime;
      });
    }
  }

  void _endTimePicker() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (newTime != null) {
      setState(() {
        endTime = newTime;
      });
    }
  }

}

class FinalAdd extends StatefulWidget {
  ModeModel mode;
  String title;
  ValueNotifier<List<ApplicationWithIcon>> selectedApps;
  TimeOfDay startTime;
  TimeOfDay endTime;
  List allApps;

  FinalAdd({Key key, this.allApps, this.mode, this.title, this.selectedApps, this.startTime, this.endTime}) : super(key: key);

  @override
  _FinalAddState createState() => _FinalAddState(allApps: allApps, mode: mode, title: title, selectedApps: selectedApps, startTime: startTime, endTime: endTime, );
}
class _FinalAddState extends State<FinalAdd> {
  ModeModel mode;
  String title;
  ValueNotifier<List> selectedApps;
  TimeOfDay startTime;
  TimeOfDay endTime;
  List allApps;

  _FinalAddState({this.mode, this.title, this.selectedApps, this.startTime, this.endTime, this.allApps});

  Colours colours = Colours();
  Sizes sizes = Sizes();

  String wallpaperPath;

  @override
  void initState() {
    if(mode != null) {
      selectedApps = ValueNotifier(Util().listParser(mode.apps));
      wallpaperPath = mode.wallpaperPath;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(mode == null) {
      return Scaffold(
        backgroundColor: colours.black(),
        body: ListView(
          children: [
            Container(
              height: sizes.height(context, 896),
              decoration: wallpaperPath != null ? BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(wallpaperPath)),
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                        colours.black().withOpacity(0.75),
                        BlendMode.dstATop),
                  )
              ) : BoxDecoration(color: colours.black()),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: colours.white(),
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProductSans',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.width(context, 48)),
                        child: Divider(
                          height: sizes.height(context, 6),
                          thickness: 6,
                          color: colours.white(),
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(top: sizes.height(context, 16)),
                        child: Text(
                          startTime.hour.toString() + ":" + (startTime.minute ==
                              0 ? startTime.minute.toString() + "0" : startTime
                              .minute.toString())
                              + " - " + endTime.hour.toString() + ":" +
                              (endTime.minute == 0 ? endTime.minute.toString() +
                                  "0" : endTime.minute.toString()),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontSize: 20,
                              color: colours.white()
                          ),
                        ),
                      ),
                      SizedBox(height: sizes.height(context, 175),),

                      // selected Apps List
                      ValueListenableBuilder(
                          valueListenable: selectedApps,
                          builder: (context, value, child) {
                            return Container(
                              margin: EdgeInsets.only(left: sizes.width(context, 42)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: sizes.width(context, 414),
                                    height: sizes.height(context, 64),
                                    child: ListView.builder(
                                      itemCount: selectedApps.value.length > 5 ? 5 : selectedApps.value.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, listIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            selectedApps.value.removeAt(listIndex);
                                            selectedApps.notifyListeners();
                                          },
                                          child: Container(
                                            width: sizes.width(context, 50),
                                            height: sizes.height(context, 64),
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: colours.white(), width: 3),
                                              color: colours.white(), // change with colours.black(),
                                            ),
                                            child: Image(
                                              image: MemoryImage(selectedApps.value[listIndex].icon),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: sizes.height(context, 32)),
                                  SizedBox(
                                    width: sizes.width(context, 414),
                                    height: sizes.height(context, 64),
                                    child: ListView.builder(
                                      itemCount: selectedApps.value.length > 5 ? (selectedApps.value.length - 5) : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, listIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            selectedApps.value.removeAt(listIndex+5);
                                            selectedApps.notifyListeners();
                                          },
                                          child: Container(
                                            width: sizes.width(context, 50),
                                            height: sizes.height(context, 64),
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: colours.white(), width: 3),
                                                color: colours.white() // change with colours.black()
                                            ),
                                            child: Image(
                                              image: MemoryImage(Util().getAppIcon(selectedApps.value[(listIndex + 5)].icon)),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),

                      SizedBox(height: sizes.height(context, 120)),

                      GestureDetector(
                        onTap: () async {
                          // _pickWallpaper();
                          wallpaperPath = await Util().pickImage();
                          FirebaseAnalytics().logEvent(name: "clicked_wallpaper_add");
                          setState(() {});
                        },
                        child: Container(
                          width: sizes.width(context, 200),
                          height: sizes.height(context, 60),
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            color: colours.white(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.image_rounded,
                                color: colours.black(),
                                size: sizes.width(context, 28),
                              ),
                              Text(
                                'add wallpaper',
                                style: TextStyle(
                                    color: colours.black(),
                                    fontSize: 20,
                                    fontFamily: 'ProductSans'
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: sizes.height(context, 24)),

                      Container(
                        width: sizes.width(context, 400),
                        height: sizes.height(context, 100),
                        child: ListView.builder(
                          itemCount: allApps.length,

                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // Map dataObject = appList[index];
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: ValueListenableBuilder(
                                        valueListenable: selectedApps,
                                        builder: (context, value, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              bool duplicate = false;
                                              for(int i=0;i<selectedApps.value.length;i++) {
                                                if(selectedApps.value[i].packageName == allApps[index].packageName) {
                                                  duplicate = true;
                                                  break;
                                                }
                                                else {
                                                  duplicate = false;
                                                }
                                              }
                                              if(!duplicate) {
                                                if(selectedApps.value.length <= 9) {
                                                  selectedApps.value.add(allApps[index]);
                                                }
                                                else {
                                                  final duplicateOrExceedSnackBar = SnackBar(
                                                    content: Text(
                                                      "Only 10 apps are allowed in a single mode, click the app to remove it",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: colours.white(),
                                                          fontSize: 18,
                                                          fontFamily: 'ProductSans'
                                                      ),
                                                    ),
                                                    action: SnackBarAction(
                                                      label: 'Ok',
                                                      onPressed: () {},
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(duplicateOrExceedSnackBar);
                                                }
                                              }
                                              selectedApps.notifyListeners();
                                            },
                                            child: Container(
                                              width: sizes.width(context, 50),
                                              height: sizes.height(context, 64),
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: colours.white(), width: 3),
                                                  color: colours.white() // change with colours.black()
                                              ),
                                              child: Image(
                                                image: MemoryImage(allApps[index].icon),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sizes.height(context, 800)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              FirebaseAnalytics().logEvent(name: "went_back_timeaddd");
                            },
                            child: Text(
                              'back',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white().withOpacity(.7)
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if(!(await ModeService().checkForDuplicate(title))) {
                                String formattedStartTime = Util().getStringFromTimeOfDay(startTime);
                                String formattedEndTime = Util().getStringFromTimeOfDay(endTime);
                                if(DateTime.parse(formattedEndTime).hour < DateTime.parse(formattedStartTime).hour) {
                                  String temp = formattedStartTime;
                                  formattedStartTime = formattedEndTime;
                                  formattedEndTime = temp;
                                }
                                ModeService().insertMode(title, formattedStartTime, formattedEndTime, selectedApps.value, wallpaperPath);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                              }
                              else {
                                final duplicateSnackBar = SnackBar(
                                  content: Text('Name of the mode is duplicate, change it'),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(duplicateSnackBar);
                              }
                              FirebaseAnalytics().logEvent(name: "added_new mode");
                            },
                            child: Text(
                              'confirm',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white()
                              ),
                            ),
                          ),
                        ],
                      ),
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
      return FutureBuilder(
          future: Util().getAllApps(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              allApps = snapshot.data;
              return Scaffold(
                backgroundColor: colours.black(),
                body: ListView(
                  children: [
                    Container(
                      height: sizes.height(context, 896),
                      decoration: wallpaperPath != null ? BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(wallpaperPath)),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(colours.black().withOpacity(0.75),
                                BlendMode.dstATop),
                          )
                      ) : BoxDecoration(color: colours.black()),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 0),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                                  child: SizedBox(
                                    width: sizes.width(context, 414),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      onChanged: (newTitle) {
                                        title = newTitle;
                                      },
                                      onTap: () {
                                        FirebaseAnalytics().logEvent(name: "updated_title");
                                      },
                                      style: TextStyle(
                                        color: colours.white(),
                                        fontSize: 64,
                                        fontFamily: 'ProductSans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: mode.title,
                                        hintMaxLines: 1,
                                        hintStyle: TextStyle(
                                          color: colours.white().withOpacity(.9),
                                          fontSize: 64,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ProductSans',
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                                child: Divider(
                                  height: sizes.height(context, 6),
                                  thickness: 6,
                                  color: colours.white(),
                                ),
                              ),
                              Container(
                                margin:  EdgeInsets.only(top: sizes.height(context, 16)),
                                child: Text(
                                  DateTime.parse(mode.startTime).hour.toString() + ":" + (DateTime.parse(mode.startTime).minute == 0 ? DateTime.parse(mode.startTime).minute.toString() + "0" : DateTime.parse(mode.startTime).minute.toString())
                                      + " - " + DateTime.parse(mode.endTime).hour.toString() + ":" + (DateTime.parse(mode.endTime).minute == 0 ? DateTime.parse(mode.endTime).minute.toString() + "0" : DateTime.parse(mode.endTime).minute.toString()),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontSize: 20,
                                      color: colours.white()
                                  ),
                                ),
                              ),
                              SizedBox(height: sizes.height(context, 175),),

                              // selected Apps here
                              ValueListenableBuilder(
                                  valueListenable: selectedApps,
                                  builder: (context, value, child) {
                                    return Container(
                                      margin: EdgeInsets.only(left: sizes.width(context, 42)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: sizes.width(context, 414),
                                            height: sizes.height(context, 64),
                                            child: ListView.builder(
                                              itemCount: selectedApps.value.length > 5 ? 5 : selectedApps.value.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, listIndex) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    selectedApps.value.removeAt(listIndex);
                                                    selectedApps.notifyListeners();
                                                    FirebaseAnalytics().logEvent(name: "updated_removed app");
                                                  },
                                                  child: Container(
                                                    width: sizes.width(context, 50),
                                                    height: sizes.height(context, 64),
                                                    margin: EdgeInsets.only(right: 20),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: colours.white(), width: 3),
                                                      color: colours.white(), // change with colours.black(),
                                                    ),
                                                    child: Image(
                                                      image: MemoryImage(Util().getAppIcon(selectedApps.value[listIndex]["icon"])),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: sizes.height(context, 32)),
                                          SizedBox(
                                            width: sizes.width(context, 414),
                                            height: sizes.height(context, 64),
                                            child: ListView.builder(
                                              itemCount: selectedApps.value.length > 5 ? (selectedApps.value.length - 5) : 0,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, listIndex) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    selectedApps.value.removeAt(listIndex+5);
                                                    selectedApps.notifyListeners();
                                                    FirebaseAnalytics().logEvent(name: "updated_removed_app");
                                                  },
                                                  child: Container(
                                                    width: sizes.width(context, 50),
                                                    height: sizes.height(context, 64),
                                                    margin: EdgeInsets.only(right: 20),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: colours.white(), width: 3),
                                                        color: colours.white() // change with colours.black()
                                                    ),
                                                    child: Image(
                                                      image: MemoryImage(Util().getAppIcon(selectedApps.value[(listIndex + 5)]["icon"])),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),

                              SizedBox(height: sizes.height(context, 54)),

                              GestureDetector(
                                onTap: () async {
                                  // _pickWallpaper();
                                  wallpaperPath = await Util().pickImage();
                                  FirebaseAnalytics().logEvent(name: "updated_changed_wallpaper");
                                  setState(() {});
                                },
                                child: Container(
                                  width: sizes.width(context, 200),
                                  height: sizes.height(context, 60),
                                  margin: EdgeInsets.only(top: 24),
                                  decoration: BoxDecoration(
                                    color: colours.white(),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.image_rounded,
                                        color: colours.black(),
                                        size: sizes.width(context, 28),
                                      ),
                                      Text(
                                        'add wallpaper',
                                        style: TextStyle(
                                            color: colours.black(),
                                            fontSize: 20,
                                            fontFamily: 'ProductSans'
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: sizes.height(context, 24)),

                              Container(
                                width: sizes.width(context, 400),
                                height: sizes.height(context, 100),
                                child: ListView.builder(
                                  itemCount: allApps.length,

                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    // Map dataObject = appList[index];
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: ValueListenableBuilder(
                                                valueListenable: selectedApps,
                                                builder: (context, value, child) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      bool duplicate = false;
                                                      for(int i=0;i<selectedApps.value.length;i++) {
                                                        if(selectedApps.value[i]["package"] == allApps[index].packageName) {
                                                          duplicate = true;
                                                          break;
                                                        }
                                                        else {
                                                          duplicate = false;
                                                        }
                                                      }
                                                      if(!duplicate) {
                                                        if(selectedApps.value.length <= 9) {
                                                          selectedApps.value.add(Util().convertApplicationWithIconToMap(allApps[index]));
                                                        }
                                                        else {
                                                          final duplicateOrExceedSnackBar = SnackBar(
                                                            content: Text(
                                                              "Only 10 apps are allowed in a single mode, click the app to remove it",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: colours.white(),
                                                                  fontSize: 18,
                                                                  fontFamily: 'ProductSans'
                                                              ),
                                                            ),
                                                            action: SnackBarAction(
                                                              label: 'Ok',
                                                              onPressed: () {},
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(context).showSnackBar(duplicateOrExceedSnackBar);
                                                        }
                                                      }
                                                      selectedApps.notifyListeners();
                                                      FirebaseAnalytics().logEvent(name: "updated_added_app");
                                                    },
                                                    child: Container(
                                                      width: sizes.width(context, 50),
                                                      height: sizes.height(context, 64),
                                                      margin: EdgeInsets.only(right: 8),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: colours.white(), width: 3),
                                                          color: colours.white() // change with colours.black()
                                                      ),
                                                      child: Image(
                                                        image: MemoryImage(allApps[index].icon),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: sizes.height(context, 800)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      FirebaseAnalytics().logEvent(name: "went_back_from_editing");
                                    },
                                    child: Text(
                                      'back',
                                      style: TextStyle(
                                          fontFamily: 'ProductSans',
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: colours.white().withOpacity(.7)
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(title == null) {
                                        ModeService().updateMode(mode.id, mode.title, mode.startTime, mode.endTime, selectedApps.value, wallpaperPath);
                                      }
                                      else {
                                        if(!(await ModeService().checkForDuplicate(title))) {
                                          ModeService().updateMode(mode.id, title, mode.startTime, mode.endTime, selectedApps.value, wallpaperPath, prevTitle: mode.title);
                                        }
                                        else {
                                          final duplicateSnackBar = SnackBar(
                                            content: Text('Name of the mode is duplicate, change it'),
                                            action: SnackBarAction(
                                              label: 'Ok',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(duplicateSnackBar);
                                        }
                                      }

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Home();
                                          },
                                        ),
                                      );
                                      FirebaseAnalytics().logEvent(name: "updated");
                                    },
                                    child: Text(
                                      'update',
                                      style: TextStyle(
                                          fontFamily: 'ProductSans',
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: colours.white()
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
              log("loading");
              return loadingWidget.Loading();
            }
          }
      );
    }
  }
}


