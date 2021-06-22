import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

import 'home.dart';

class TitleAdd extends StatefulWidget {
  ModeModel mode;
  TitleAdd({Key key, this.mode}) : super(key: key);

  @override
  _TitleAddState createState() => _TitleAddState();
}
class _TitleAddState extends State<TitleAdd> {
  Colours colours = Colours();
  Sizes sizes = Sizes();

  String title = "Give a title";

  @override
  void initState() {
    if(widget.mode != null) {
      title = widget.mode.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  'TYPE A HEADING',
                  style: TextStyle(
                      fontSize: 18,
                      color: colours.white(),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CustomDialogs().category(context, sizes, colours);
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
          SizedBox(height: sizes.height(context, 24)),

          TextField(
            textAlign: TextAlign.center,
            onChanged: (newTitle) {
              title = newTitle;
            },
            onTap: () {
              FirebaseAnalytics().logEvent(name: "added_title");
            },
            style: TextStyle(
              color: colours.white(),
              fontSize: 54,
              fontFamily: 'ProductSans',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25
            ),
            decoration: InputDecoration(
              hintText: title,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                color: colours.white().withOpacity(.7),
                fontSize: 64,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans',
                letterSpacing: 1.25
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
            child: Divider(
              height: sizes.height(context, 6),
              thickness: 6,
              color: title == null ? colours.white(opacity: .7) : colours.white(),
            ),
          ),
          SizedBox(height: sizes.height(context, 580)),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AppsAdd(title, mode: widget.mode);
                    },
                  ),
                );
              },
              child: Container(
                width: sizes.width(context, 375),
                height: sizes.height(context, 75),
                color: colours.white(),
                child: Center(
                  child: Text(
                    'continue',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: colours.black(),
                      fontFamily: 'ProductSans'
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppsAdd extends StatefulWidget {
  String title;
  ModeModel mode;
  AppsAdd(this.title, {Key key, this.mode}) : super(key: key);

  @override
  _AppsAddState createState() => _AppsAddState();
}
class _AppsAddState extends State<AppsAdd> {
  _AppsAddState();

  Colours colours = Colours();
  Sizes sizes = Sizes();

  ValueNotifier<List> modeApps = ValueNotifier([]);

  @override
  void initState() {
    if(widget.mode != null) {
      List parsedModeApps = Util().listDecoder(widget.mode.apps);
      modeApps.value.addAll(parsedModeApps);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  'CLICK THE APPS',
                  style: TextStyle(
                      fontSize: 18,
                      color: colours.white(),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CustomDialogs().category(context, sizes, colours);
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

          FutureBuilder(
              future: Util().getAllApps(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  EasyLoading.dismiss();
                  List installedApps = Util().convertListApplicationWithIconToListMap(snapshot.data);

                  return ValueListenableBuilder(
                    valueListenable: modeApps,
                    builder: (context, List newModeApps, child) {
                      return SizedBox(
                        height: Sizes().height(context, 690),
                        width: Sizes().width(context, 414),
                        child: GridView.count(
                          crossAxisCount: 5,
                          mainAxisSpacing: 24,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(
                            installedApps != null ? installedApps.length : 0, (index) {
                              bool isAppInMode = Util().checkIfAppIsInMode(newModeApps, installedApps, index);
                              return GestureDetector(
                                onTap: () {
                                  if(isAppInMode) {
                                    print("in if");
                                    newModeApps.remove(installedApps[index]);
                                    print("length: " + newModeApps.length.toString());
                                  }
                                  else {
                                    print("in else");
                                    newModeApps.add(installedApps[index]);
                                  }
                                  modeApps.notifyListeners();
                                },
                                child: Container(
                                  width: sizes.width(context, 54),
                                  height: sizes.height(context, 74),
                                  margin: EdgeInsets.only(left: 16, right: 16),
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
                  );
                }
                else {
                  EasyLoading.show(status: 'loading...');
                  return SizedBox();
                }
              }
          ),
          SizedBox(height: sizes.height(context, 12)),

          Center(
            child: GestureDetector(
              onTap: () {
                modeApps.value != null ? Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TimeAdd(widget.title, modeApps, mode: widget.mode);
                    },
                  ),
                ) : print("no title");
              },
              child: Container(
                width: sizes.width(context, 375),
                height: sizes.height(context, 75),
                color: colours.white(),
                child: Center(
                  child: Text(
                    'continue',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: colours.black(),
                        fontFamily: 'ProductSans'
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TimeAdd extends StatefulWidget {
  String title;
  ValueNotifier<List> modeApps;
  ModeModel mode;
  TimeAdd(this.title, this.modeApps, {Key key, this.mode}) : super(key: key);

  @override
  _TimeAddState createState() => _TimeAddState();
}
class _TimeAddState extends State<TimeAdd> {
  Colours colours = Colours();
  Sizes sizes = Sizes();

  TimeOfDay startTime = TimeOfDay(hour: 6, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);

  @override
  void initState() {
    if(widget.mode != null) {
      DateTime startDateTime = DateTime.parse(widget.mode.startTime);
      DateTime endDateTime = DateTime.parse(widget.mode.endTime);

      startTime = TimeOfDay(hour: startDateTime.hour, minute: startDateTime.minute);
      endTime = TimeOfDay(hour: endDateTime.hour, minute: endDateTime.minute);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  'ADD THE TIME',
                  style: TextStyle(
                      fontSize: 18,
                      color: colours.white(),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CustomDialogs().category(context, sizes, colours);
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
          SizedBox(height: sizes.height(context, 70)),

          Center(
            child: Text(
              (startTime.hour < 10 ? "0" + startTime.hour.toString() : startTime.hour.toString()) + ":" + (startTime.minute == 0 ? startTime.minute.toString() + "0" : startTime.minute.toString()),
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: colours.white(),
                fontFamily: 'ProductSans'
              ),
            ),
          ),
          SizedBox(height: sizes.height(context, 16)),
          Center(
            child: GestureDetector(
              onTap: () async {
                startTime = await Util().timePicker(context, startTime);
                setState(() {});
              },
              child: Container(
                width: sizes.width(context, 150),
                height: sizes.height(context, 48),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: colours.white(), width: 3)
                ),
                child: Center(
                  child: Text(
                    'start time',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colours.white(),
                        fontFamily: 'ProductSans'
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: sizes.height(context, 48)),

          Icon(
            Icons.arrow_downward,
            size: sizes.height(context, 80),
            color: colours.white(),
          ),
          SizedBox(height: sizes.height(context, 48)),

          Center(
            child: Text(
              (endTime.hour < 10 ? "0" + endTime.hour.toString() : endTime.hour.toString()) + ":" + (endTime.minute == 0 ? endTime.minute.toString() + "0" : endTime.minute.toString()),
              style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                  color: colours.white(),
                  fontFamily: 'ProductSans'
              ),
            ),
          ),
          SizedBox(height: sizes.height(context, 16)),
          Center(
            child: GestureDetector(
              onTap: () async {
                endTime = await Util().timePicker(context, endTime);
                setState(() {});
              },
              child: Container(
                width: sizes.width(context, 150),
                height: sizes.height(context, 48),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: colours.white(), width: 3)
                ),
                child: Center(
                  child: Text(
                    'end time',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colours.white(),
                        fontFamily: 'ProductSans'
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: sizes.height(context, 100)),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FinalAdd(widget.title, widget.modeApps, startTime, endTime, mode: widget.mode);
                    },
                  ),
                );
              },
              child: Container(
                width: sizes.width(context, 375),
                height: sizes.height(context, 75),
                color: colours.white(),
                child: Center(
                  child: Text(
                    'continue',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: colours.black(),
                        fontFamily: 'ProductSans'
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FinalAdd extends StatefulWidget {
  String title;
  ValueNotifier<List> modeApps;
  TimeOfDay startTime;
  TimeOfDay endTime;
  ModeModel mode;

  FinalAdd(this.title, this.modeApps, this.startTime, this.endTime, {Key key, this.mode}) : super(key: key);

  @override
  _FinalAddState createState() => _FinalAddState();
}

class _FinalAddState extends State<FinalAdd> {

  Sizes sizes = Sizes();
  Colours colours = Colours();

  String wallpaperPath;

  @override
  void initState() {
    if(widget.mode != null) {
      wallpaperPath = widget.mode.wallpaperPath;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: ListView(
        children: [
          wallpaperPath == null ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      'ADD WALLPAPER',
                      style: TextStyle(
                          fontSize: 18,
                          color: colours.white(),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        CustomDialogs().category(context, sizes, colours);
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
              SizedBox(height: sizes.height(context, 170)),

              GestureDetector(
                onTap: () async {
                  wallpaperPath = await Util().pickImage();
                  setState(() {});
                },
                child: Column(
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('assets/Image.png'),
                        width: sizes.width(context, 225),
                        fit: BoxFit.fill,
                        color: colours.white(),
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 42)),
                    Center(
                      child: Text(
                        'click the icon to\n add your wallpaper',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: colours.white(),
                          height: .8,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ProductSans'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizes.height(context, 205)),

              Center(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    width: sizes.width(context, 375),
                    height: sizes.height(context, 75),
                    color: colours.white(),
                    child: Center(
                      child: Text(
                        'confirm',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: colours.black(),
                            fontFamily: 'ProductSans'
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ) : Stack(
            children: [
              Container(
                width: sizes.width(context, 414),
                height: sizes.height(context, 896),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(wallpaperPath)),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(colours.black().withOpacity(0.6),
                        BlendMode.dstATop),
                  )
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          'ADD WALLPAPER',
                          style: TextStyle(
                              fontSize: 18,
                              color: colours.white(),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomDialogs().category(context, sizes, colours);
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
                  SizedBox(height: sizes.height(context, 36)),

                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 72,
                        color: colours.white(),
                        fontFamily: 'ProductSans'
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 10)),
                  Center(
                    child: Text(
                      widget.startTime.hour.toString() + ":" + (widget.startTime.minute == 0 ? widget.startTime.minute.toString() + "0" : widget.startTime.minute.toString())
                          + " - " + widget.endTime.hour.toString() + ":" + (widget.endTime.minute == 0 ? widget.endTime.minute.toString() + "0" : widget.endTime.minute.toString()),
                      style: TextStyle(
                        fontSize: 24,
                        color: colours.white(),
                        fontFamily: 'ProductSans'
                      ),
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 550)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if(!(await ModeService().checkForDuplicate(widget.title))) {
                                String formattedStartTime = Util().getStringFromTimeOfDay(widget.startTime);
                                String formattedEndTime = Util().getStringFromTimeOfDay(widget.endTime);
                                if(DateTime.parse(formattedEndTime).hour < DateTime.parse(formattedStartTime).hour) {
                                  String temp = formattedStartTime;
                                  formattedStartTime = formattedEndTime;
                                  formattedEndTime = temp;
                                }

                                if(widget.mode != null) {
                                  ModeService().updateMode(1, widget.title, formattedStartTime, formattedEndTime, widget.modeApps.value, wallpaperPath, prevTitle: widget.mode.title);
                                }
                                else {
                                  ModeService().insertMode(widget.title, formattedStartTime, formattedEndTime, widget.modeApps.value, wallpaperPath);
                                }

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
                            },
                            child: Container(
                              width: sizes.width(context, 300),
                              height: sizes.height(context, 75),
                              decoration: BoxDecoration(
                                color: colours.white(),
                                border: Border.all(color: colours.black(), width: 3)
                              ),
                              child: Center(
                                child: Text(
                                  'confirm',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: colours.black(),
                                      fontFamily: 'ProductSans'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              wallpaperPath = await Util().pickImage();
                              setState(() {});
                            },
                            child: Container(
                              width: sizes.width(context, 75),
                              height: sizes.height(context, 75),
                              decoration: BoxDecoration(
                                  color: colours.white(),
                                  border: Border.all(color: colours.black(), width: 3)
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: sizes.width(context, 36),
                                  color: colours.black(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}





