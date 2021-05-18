import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';
import 'package:palette_generator/palette_generator.dart';

import 'home.dart';

// todo: performance issues because fof getAddScreens

class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Colours colours = Colours();
  Sizes sizes = Sizes();
  final picker = ImagePicker();

  int addScreenTracker = 0;

  String title = "Work";
  List selectedApps = [];
  TimeOfDay startTime = TimeOfDay(hour: 6, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 00);
  String wallpaperPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: FutureBuilder(
        future: ModeService().getAllApps(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List apps = snapshot.data;
            return Container(
              decoration: wallpaperPath != null ? BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(wallpaperPath)),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(colours.black().withOpacity(0.75),
                      BlendMode.dstATop),
                ),
              ) : BoxDecoration(color: colours.black()),
              child: Stack(
                children: [
                  wallpaperPath != null ? getAddScreen(apps) : getAddScreen(apps),
                  Padding(
                    padding: EdgeInsets.only(top: sizes.height(context, 840)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(addScreenTracker != 0) {
                                addScreenTracker--;
                              }
                              else {
                                Navigator.of(context).pop();
                              }
                              setState(() {});
                            },
                            child: Text(
                              'back',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white().withOpacity(.7),
                                  shadows: [
                                    Shadow(
                                        offset: Offset(8, 8),
                                        color: colours.black().withOpacity(.6),
                                        blurRadius: 32
                                    )
                                  ]
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if(addScreenTracker == 3) {
                                String formattedStartTime = getStringFromTimeOfDay(startTime);
                                String formattedEndTime = getStringFromTimeOfDay(endTime);
                                ModeService().insertMode(title, formattedStartTime, formattedEndTime, selectedApps, wallpaperPath);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );                                  }
                              else {
                                addScreenTracker++;
                              }
                              setState(() {});
                            },
                            child: Text(
                              addScreenTracker == 3 ? 'confirm' : 'continue',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  shadows: [
                                    Shadow(
                                        offset: Offset(8, 8),
                                        color: colours.black().withOpacity(.8),
                                        blurRadius: 32
                                    )
                                  ]
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
          else {
            return SizedBox();
          }
        }
      ),
    );
  }

  Widget getAddScreen(List apps) {
    Widget addScreen;
    switch(addScreenTracker) {
      case 0:
        addScreen = ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 16,),
                Center(
                  child: TextField(
                    // enabled: false,
                    textAlign: TextAlign.center,
                    onChanged: (newTitle) {
                      title = newTitle;
                    },
                    style: TextStyle(
                      color: colours.white(),
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Work",
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        color: colours.white().withOpacity(.7),
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
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
                  margin: const EdgeInsets.only(top: 16),
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
          ],
        );
        break;
      case 1:
        addScreen = ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 16,),
                Center(
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    onChanged: (newTitle) {
                      title = newTitle;
                    },
                    style: TextStyle(
                      color: colours.white(),
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Work",
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        color: colours.white(),
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width(context, 48)),
                  child: Divider(
                    height: sizes.height(context, 6),
                    thickness: 6,
                    color: colours.white().withOpacity(1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Text(
                    'click apps that you will use in this mode',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                        color: colours.white()
                    ),
                  ),
                ),

                SizedBox(
                  width: sizes.width(context, 350),
                  height: sizes.height(context, 440),
                  child: ListView.builder(
                    itemCount: selectedApps.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      // Map dataObject = appList[index];
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedApps.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: sizes.width(context, 64),
                                  height: sizes.height(context, 72),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: colours.white(), width: 3),
                                      color: colours.white()
                                  ),
                                  child: Image(
                                    image: MemoryImage(selectedApps[index]["icon"]),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: sizes.height(context, 60)),

                SizedBox(height: 6),
                SizedBox(
                  width: sizes.width(context, 400),
                  height: sizes.height(context, 100),
                  child: ListView.builder(
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
                              child: GestureDetector(
                                onTap: () {
                                  bool duplicate = false;
                                  selectedApps.forEach((element) {
                                    if(element["package"] == apps[index]["package"]) {
                                      duplicate = true;
                                    }
                                    else {
                                      duplicate = false;
                                    }
                                  });
                                  setState(() {
                                    !duplicate ? selectedApps.add(apps[index]) : print("dupli");
                                  });
                                },
                                child: Container(
                                  width: sizes.width(context, 50),
                                  height: sizes.height(context, 64),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colours.white() // change with colours.black()
                                  ),
                                  child: Image(
                                    image: MemoryImage(apps[index]["icon"]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
          ],
        );
        break;
      case 2:
        addScreen = ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 16,),
                Center(
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    onChanged: (newTitle) {
                      title = newTitle;
                    },
                    style: TextStyle(
                      color: colours.white(),
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Work",
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        color: colours.white(),
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
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
                  margin: const EdgeInsets.only(top: 16),
                  child: Text(
                    'add the time you will use these apps',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                        color: colours.white()
                    ),
                  ),
                ),

                SizedBox(
                  width: sizes.width(context, 350),
                  height: sizes.height(context, 440),
                  child: ListView.builder(
                    itemCount: selectedApps.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      // Map dataObject = appList[index];
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedApps.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: sizes.width(context, 64),
                                  height: sizes.height(context, 72),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: colours.white(), width: 3),
                                      color: colours.white()
                                  ),
                                  child: Image(
                                    image: MemoryImage(selectedApps[index]["icon"]),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _startTimePicker();
                      },
                      child: Container(
                        width: sizes.width(context, 170),
                        height: sizes.height(context, 60),
                        decoration: BoxDecoration(
                          color: colours.white(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: colours.black(),
                              size: sizes.width(context, 28),
                            ),
                            Text(
                              'add start time',
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
                    GestureDetector(
                      onTap: () {
                        _endTimePicker();
                      },
                      child: Container(
                        width: sizes.width(context, 170),
                        height: sizes.height(context, 60),
                        decoration: BoxDecoration(
                          color: colours.white(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: colours.black(),
                              size: sizes.width(context, 28),
                            ),
                            Text(
                              'add end time',
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
                  ],
                ),

                SizedBox(height: 6),
                SizedBox(
                  width: sizes.width(context, 400),
                  height: sizes.height(context, 100),
                  child: ListView.builder(
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
                              child: GestureDetector(
                                onTap: () {
                                  bool duplicate = true;
                                  selectedApps.forEach((element) {
                                    if(element["package"] == apps[index]["package"]) {
                                      duplicate = true;
                                    }
                                    else {
                                      duplicate = false;
                                    }
                                  });
                                  setState(() {
                                    !duplicate ? selectedApps.add(apps[index]) : print("dupli");
                                  });
                                },
                                child: Container(
                                  width: sizes.width(context, 50),
                                  height: sizes.height(context, 64),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colours.white() // change with colours.black()
                                  ),
                                  child: Image(
                                    image: MemoryImage(apps[index]["icon"]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
          ],
        );
        break;
      case 3:
        addScreen = Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: TextField(
                enabled: false,
                textAlign: TextAlign.center,
                onChanged: (newTitle) {
                  title = newTitle;
                },
                style: TextStyle(
                  color: colours.white(),
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Work",
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: colours.white(),
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Text(
                startTime.hour.toString() + ":" + (startTime.minute == 0 ? startTime.minute.toString() + "0" : startTime.minute.toString())
                    + " - " + endTime.hour.toString() + ":" + (endTime.minute == 0 ? endTime.minute.toString() + "0" : endTime.minute.toString()),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 20,
                    color: colours.white()
                ),
              ),
            ),

            SizedBox(
              width: sizes.width(context, 350),
              height: sizes.height(context, 440),
              child: ListView.builder(
                itemCount: selectedApps.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  // Map dataObject = appList[index];
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedApps.removeAt(index);
                              });
                            },
                            child: Container(
                              width: sizes.width(context, 64),
                              height: sizes.height(context, 72),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: colours.white(), width: 3),
                                  color: colours.white()
                              ),
                              child: Image(
                                image: MemoryImage(selectedApps[index]["icon"]),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            GestureDetector(
              onTap: () {
                _pickWallpaper();
              },
              child: Container(
                width: sizes.width(context, 200),
                height: sizes.height(context, 60),
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
                      'add wallpapaer',
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

            SizedBox(height: 20),
            SizedBox(
              width: sizes.width(context, 400),
              height: sizes.height(context, 100),
              child: ListView.builder(
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
                          child: GestureDetector(
                            onTap: () {
                              bool duplicate = true;
                              selectedApps.forEach((element) {
                                if(element["package"] == apps[index]["package"]) {
                                  duplicate = true;
                                }
                                else {
                                  duplicate = false;
                                }
                              });
                              setState(() {
                                !duplicate ? selectedApps.add(apps[index]) : print("dupli");
                              });
                            },
                            child: Container(
                              width: sizes.width(context, 50),
                              height: sizes.height(context, 64),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colours.white() // change with colours.black()
                              ),
                              child: Image(
                                image: MemoryImage(apps[index]["icon"]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
        break;
    }
    return addScreen;
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

  _pickWallpaper() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        wallpaperPath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Color> getDominantColor() async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        FileImage(File(wallpaperPath))
    );
    print("paletteGenerator.lightVibrantColor.color: " + paletteGenerator.lightVibrantColor.color.toString());
    return wallpaperPath != null ? paletteGenerator.lightVibrantColor.color : colours.white();
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  String getStringFromTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final newDt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return newDt.toString();
  }
}

class Edit extends StatefulWidget {
  ModeModel mode;

  Edit({Key key, this.mode}) : super(key: key);

  @override
  _EditState createState() => _EditState(mode);
}

class _EditState extends State<Edit> {

  Sizes sizes = Sizes();
  Colours colours = Colours();
  final picker = ImagePicker();

  ModeModel mode;

  _EditState(this.mode);

  String title;
  String wallpaper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.white(),
      body: FutureBuilder(
          future: ModeService().getAllApps(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List apps = snapshot.data;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: wallpaper != null ? FileImage(File(wallpaper)) : FileImage(File(mode.wallpaperPath)),
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(colours.black().withOpacity(0.75),
                        BlendMode.dstATop),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        Center(
                          child: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            onChanged: (newTitle) {
                              title = newTitle;
                            },
                            style: TextStyle(
                              color: colours.white(),
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: mode.title,
                              hintMaxLines: 1,
                              hintStyle: TextStyle(
                                color: colours.white(),
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          child: Text(
                            parseDateTime(mode.startTime).hour.toString() + ":" + (parseDateTime(mode.startTime).minute == 0 ? parseDateTime(mode.startTime).minute.toString() + "0" : parseDateTime(mode.startTime).minute.toString())
                                + " - " + parseDateTime(mode.endTime).hour.toString() + ":" + (parseDateTime(mode.endTime).minute == 0 ? parseDateTime(mode.endTime).minute.toString() + "0" : parseDateTime(mode.endTime).minute.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 20,
                                color: colours.white()
                            ),
                          ),
                        ),

                        SizedBox(
                          width: sizes.width(context, 350),
                          height: sizes.height(context, 440),
                          child: ListView.builder(
                            itemCount: listParser(mode.apps).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              // Map dataObject = appList[index];
                              return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            listParser(mode.apps).removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          width: sizes.width(context, 64),
                                          height: sizes.height(context, 72),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: colours.white(), width: 3),
                                              color: colours.white()
                                          ),
                                          child: Image(
                                            image: MemoryImage(listParser(mode.apps)[index]["icon"]),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _pickWallpaper();
                          },
                          child: Container(
                            width: sizes.width(context, 200),
                            height: sizes.height(context, 60),
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
                                  'add wallpapaer',
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

                        SizedBox(height: 20),
                        SizedBox(
                          width: sizes.width(context, 400),
                          height: sizes.height(context, 100),
                          child: ListView.builder(
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
                                      child: GestureDetector(
                                        onTap: () {
                                          bool duplicate = true;
                                          listParser(mode.apps).forEach((element) {
                                            if(element["package"] == apps[index]["package"]) {
                                              duplicate = true;
                                            }
                                            else {
                                              duplicate = false;
                                            }
                                          });
                                          setState(() {
                                            !duplicate ? listParser(mode.apps).add(apps[index]) : print("dupli");
                                          });
                                        },
                                        child: Container(
                                          width: sizes.width(context, 50),
                                          height: sizes.height(context, 64),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colours.white() // change with colours.black()
                                          ),
                                          child: Image(
                                            image: MemoryImage(apps[index]["icon"]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
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
                      padding: EdgeInsets.only(top: sizes.height(context, 840)),
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
                                    color: colours.white().withOpacity(.7),
                                    shadows: [
                                      Shadow(
                                          offset: Offset(8, 8),
                                          color: colours.black().withOpacity(.6),
                                          blurRadius: 32
                                      )
                                    ]
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                title = title != null ? title : mode.title;
                                wallpaper = wallpaper != null ? wallpaper : mode.wallpaperPath;

                                ModeService().updateMode(title, mode.startTime, mode.endTime, listParser(mode.apps), wallpaper);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'confirm',
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: colours.white(),
                                    shadows: [
                                      Shadow(
                                          offset: Offset(8, 8),
                                          color: colours.black().withOpacity(.8),
                                          blurRadius: 32
                                      )
                                    ]
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
            else {
              return SizedBox();
            }
          }
      )
    );
  }

  DateTime parseDateTime(String time) {
    return DateTime.parse(time);
  }

  List listParser(String list) {
    return json.decode(list);
  }

  _pickWallpaper() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        wallpaper = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }
}

