import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

import 'add.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Sizes sizes = Sizes();
  Colours colours = Colours();
  PageController _pageController = PageController(initialPage: 1, viewportFraction: 0.25);

  File topImage;
  File mainImage;
  File bottomImage;

  bool pageChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: FutureBuilder<List<ModeModel>>(
        future: ModeService().getAllModes(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<ModeModel> allModes = snapshot.data;
            // topImage = allModes.length == 1 ? null : File(allModes[0].wallpaperPath);
            // mainImage = allModes.length<2 ? File(allModes[0].wallpaperPath) : File(allModes[1].wallpaperPath);
            // bottomImage = allModes.length<3 ? null : File(allModes[2].wallpaperPath);
            return Column(
              children: [
                Container(
                  width: sizes.width(context, 414),
                  height: sizes.height(context, 100),
                  decoration: topImage == null ? BoxDecoration(color: Colors.blue) : BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(topImage),
                      fit: BoxFit.fitWidth
                    )
                  ),
                ), // first image

                Container(
                  width: sizes.width(context, 414),
                  height: sizes.height(context, 696),
                  decoration: mainImage == null ? BoxDecoration(color: colours.black()) : BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(mainImage),
                          fit: BoxFit.fitHeight
                      )
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'settings',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(opacity: .9)
                              ),
                            ),
                            Icon(
                              Icons.info_rounded,
                              color: colours.white(opacity: .9),
                              size: 32,
                            )
                          ],
                        ),
                      ),
                      PageView.builder(
                        itemCount: (allModes.length + 1),
                        onPageChanged: (index) {
                          setState(() {
                            topImage = index == 0 ? null : File(allModes[index-1].wallpaperPath);
                            mainImage = index == allModes.length ? null : File(allModes[index].wallpaperPath);
                            bottomImage = index >= (allModes.length-1) ? null : File(allModes[index+1].wallpaperPath);
                          });
                        },
                        itemBuilder: (context, index) {

                          if(index == allModes.length) {
                            return Text(
                              "add + " + " :: " + index.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colours.white(),
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: _pageController.page.toInt() == index ? 36 : 24
                              ),
                            );
                          }
                          else {
                            return Text(
                              allModes[index].title + " :: " + index.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colours.white(),
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.bold,
                                fontSize: _pageController.page.toInt() == index ? 36 : 24
                              ),
                            );
                          }
                        },
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                      ),
                    ],
                  ),
                ), // main image

                Container(
                  width: sizes.width(context, 414),
                  height: sizes.height(context, 100),
                  decoration: bottomImage == null ? BoxDecoration(color: Colors.greenAccent) : BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(bottomImage),
                          fit: BoxFit.fitWidth
                      )
                  ),
                ), // last image
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
}
//


