import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/screens/add.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

class AllModes extends StatelessWidget {
  AllModes({Key key}) : super(key: key);

  Sizes sizes = Sizes();
  Colours colours = Colours();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: Column(
        children: [
          SizedBox(height: sizes.height(context, 28)),
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
                  'TOUCH TO EDIT',
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

          FutureBuilder(
            future: ModeService().getAllModes(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                EasyLoading.dismiss();
                List<ModeModel> allModes = snapshot.data;
                return SizedBox(
                  width: sizes.width(context, 380),
                  height: sizes.height(context, 785),
                  child: ListView.builder(
                    itemCount: allModes.length,
                    itemBuilder: (context, index) {
                      ModeModel mode = allModes[index];
                      DateTime startTime = DateTime.parse(mode.startTime);
                      DateTime endTime = DateTime.parse(mode.endTime);

                      return Align(
                        heightFactor: .8,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TitleAdd(mode: mode,);
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: sizes.width(context, 380),
                            height: sizes.height(context, 350),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              image: DecorationImage(
                                  image: FileImage(File(mode.wallpaperPath)),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Colours().black(opacity: .35), BlendMode.srcOver)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, -24),
                                  blurRadius: 48,
                                  color: colours.black(opacity: .85)
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: sizes.height(context, 110),),
                                Text(
                                  mode.title,
                                  style: TextStyle(
                                    fontSize: 36,
                                    color: colours.white(opacity: .9),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProductSans'
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  startTime.hour.toString() + ":" + (startTime.minute == 0 ? startTime.minute.toString() + "0" : startTime.minute.toString())
                                      + " - " + endTime.hour.toString() + ":" + (endTime.minute == 0 ? endTime.minute.toString() + "0" : endTime.minute.toString()),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colours.white(),
                                      fontFamily: 'ProductSans'
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else {
                return SizedBox();
              }
            }
          )
        ],
      ),
    );
  }
}
