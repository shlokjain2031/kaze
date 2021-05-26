import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';
import 'package:launcher_assist/launcher_assist.dart';

import 'add.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Sizes sizes = Sizes();
  Colours colours = Colours();
  PageController _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
  int pageNum = 1; // _pageController's initialPage value;

  @override
  void initState() {
    super.initState();
    print("yello");
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        backgroundColor: colours.black(),
        body: FutureBuilder<List<ModeModel>>(
          future: ModeService().getAllModes(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List<ModeModel> allModes = snapshot.data;

              return PageView.builder(
                controller: _pageController,
                itemCount: (allModes.length + 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (index == allModes.length) {
                    return GestureDetector(
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
                  else {
                    ModeModel mode = allModes[index];
                    DateTime startTime = DateTime.parse(mode.startTime);
                    DateTime endTime = DateTime.parse(mode.endTime);

                    List apps = Util().listParser(mode.apps);

                    return Container(
                      decoration: mode.wallpaperPath != null ? BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(mode.wallpaperPath)),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(colours.black().withOpacity(0.65),
                                BlendMode.dstATop),
                          ),
                          border: Border(
                              bottom: BorderSide(color: colours.white(), width: 5)
                          )
                      ) : BoxDecoration(
                          color: colours.black(),
                          border: Border(
                            bottom: BorderSide(color: colours.white(), width: 5)
                          )
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    List allApps = await Util().getAllApps();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return FinalAdd(allApps, mode: mode,);
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'edit mode',
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: colours.white(opacity: .9)
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    CustomDialogs().category(context, sizes, colours, title: mode.title);
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

                          SizedBox(height: sizes.height(context, 175)),
                          Text(
                            mode.title,
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
                            startTime.hour.toString() + ":" + (startTime.minute == 0 ? startTime.minute.toString() + "0" : startTime.minute.toString())
                                + " - " + endTime.hour.toString() + ":" + (endTime.minute == 0 ? endTime.minute.toString() + "0" : endTime.minute.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'ProductSans',
                              color: colours.white(opacity: .8),
                            ),
                          ),
                          SizedBox(height: sizes.height(context, 72)),

                          Container(
                            width: sizes.width(context, 414),
                            height: sizes.height(context, 64),
                            margin: EdgeInsets.only(left: sizes.width(context, 80)),
                            child: ListView.builder(
                              itemCount: apps.length > 4 ? 4 : apps.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, listIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    bool appCanBeUsed = ModeService().checkIfAppCanBeUsed(mode);
                                    if(appCanBeUsed) {
                                      Util().launchApp(apps[listIndex]["package"]);
                                    }
                                    else {
                                      CustomDialogs().openApp(context, sizes, colours, apps[listIndex]);
                                    }
                                  },
                                  child: Container(
                                    width: sizes.width(context, 50),
                                    height: sizes.height(context, 64),
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colours.white(),
                                        border: Border.all(color: colours.white(), width: 3)
                                    ),
                                    child: Image(
                                      image: MemoryImage(Util().getAppIcon(apps[listIndex]["icon"])),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: sizes.height(context, 32)),
                          Container(
                            width: sizes.width(context, 414),
                            height: sizes.height(context, 64),
                            margin: EdgeInsets.only(left: sizes.width(context, 80)),
                            child: ListView.builder(
                              itemCount: apps.length > 4 ? (apps.length - 4) : 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, listIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    bool appCanBeUsed = ModeService().checkIfAppCanBeUsed(mode);
                                    if(appCanBeUsed) {
                                      Util().launchApp(apps[(listIndex + 4)]["package"]);
                                    }
                                    else {
                                      CustomDialogs().openApp(context, sizes, colours, apps[(listIndex + 4)]);
                                    }
                                  },
                                  child: Container(
                                    width: sizes.width(context, 50),
                                    height: sizes.height(context, 64),
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colours.white(),
                                      border: Border.all(color: colours.white(), width: 3)
                                    ),
                                    child: Image(
                                      image: MemoryImage(Util().getAppIcon(apps[(listIndex + 4)]["icon"])),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
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

class AllApps extends StatelessWidget {
  AllApps({Key key}) : super(key: key);
  List installedApps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours().black(),
      body: FutureBuilder(
        future: Util().getAllApps(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List installedApps = snapshot.data;
            return Column(
              children: [
                SizedBox(height: 32,),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_outlined,
                        size: 48,
                        color: Colours().white(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes().height(context, 790),
                  width: Sizes().width(context, 414),
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 20,
                    physics: BouncingScrollPhysics(),
                    children: List.generate(
                      installedApps != null ? installedApps.length : 0,
                          (index) {
                        return GestureDetector(
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                iconContainer(index, installedApps),
                              ],
                            ),
                          ),
                          onTap: () {
                            CustomDialogs().openApp(context, Sizes(), Colours(), installedApps[index]);
                          }
                        );
                      },
                    ),
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
    );
  }

  iconContainer(index, installedApps) {
    try {
      return Image.memory(
        installedApps[index]["icon"] != null
            ? installedApps[index]["icon"]
            : Uint8List(0),
        height: 50,
        width: 50,
      );
    } catch (e) {
      return Container();
    }
  }
}



