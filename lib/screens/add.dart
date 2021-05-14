import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/sizes.dart';

class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Colours colours = Colours();
  Sizes sizes = Sizes();
  int addScreenTracker = 0;

  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.black(),
      body: Container(
        // wallpaper here
        child: Stack(
          children: [
            getAddScreen(),
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
                        setState(() {});
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
                        if(addScreenTracker == 3) {
                          // to home or some shit
                        }
                        else {
                          addScreenTracker++;
                        }
                        setState(() {});
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
        ),
      ),
    );
  }

  Widget getAddScreen() {
    Widget addScreen;
    switch(addScreenTracker) {
      case 0:
        addScreen = Column(
          children: [
            SizedBox(height: 16,),
            Center(
              child: TextField(
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
        );
        break;
      case 1:
        addScreen = Column(
          children: [
            SizedBox(height: 16,),
            Center(
              child: TextField(
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
              width: sizes.width(context, 350),
              height: sizes.height(context, 440),
              child: ListView.builder(
                itemCount: 4,
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
                            width: sizes.width(context, 72),
                            height: sizes.height(context, 72),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colours.white(), width: 3),
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: sizes.height(context, 60)),

            SizedBox(height: 20),
            SizedBox(
              width: sizes.width(context, 400),
              height: sizes.height(context, 100),
              child: ListView.builder(
                itemCount: 10,
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
                            width: sizes.width(context, 64),
                            height: sizes.height(context, 64),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
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
      case 2:
        addScreen = Column(
          children: [
            SizedBox(height: 16,),
            Center(
              child: TextField(
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
              width: sizes.width(context, 350),
              height: sizes.height(context, 440),
              child: ListView.builder(
                itemCount: 4,
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
                            width: sizes.width(context, 72),
                            height: sizes.height(context, 72),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colours.white(), width: 3),
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              width: sizes.width(context, 140),
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
                    'add time',
                    style: TextStyle(
                        color: colours.black(),
                        fontSize: 20,
                        fontFamily: 'ProductSans'
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: sizes.width(context, 400),
              height: sizes.height(context, 100),
              child: ListView.builder(
                itemCount: 10,
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
                            width: sizes.width(context, 64),
                            height: sizes.height(context, 64),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
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
      case 3:
        addScreen = Column(
          children: [
            SizedBox(height: 16,),
            Center(
              child: TextField(
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
              width: sizes.width(context, 350),
              height: sizes.height(context, 440),
              child: ListView.builder(
                itemCount: 4,
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
                            width: sizes.width(context, 72),
                            height: sizes.height(context, 72),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colours.white(), width: 3),
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
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

            SizedBox(height: 20),
            SizedBox(
              width: sizes.width(context, 400),
              height: sizes.height(context, 100),
              child: ListView.builder(
                itemCount: 10,
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
                            width: sizes.width(context, 64),
                            height: sizes.height(context, 64),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2F5D62) // change with colours.black()
                            ),
                            // child: Image(
                            //   image: FileImage(), add logo here
                            //   fit: BoxFit.fill,
                            // ),
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
}
