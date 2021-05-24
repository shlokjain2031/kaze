import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kaze/screens/home.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/settings.dart';
import 'package:kaze/services/util.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';
import 'package:launcher_assist/launcher_assist.dart';

class Settings extends StatefulWidget {

  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notifications = true;
  bool phone = false;
  bool backup = false;

  Sizes sizes = Sizes();
  Colours colours = Colours();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _androidBack(context);
      },
      child: FutureBuilder(
        future: SettingsService().getSettings(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<bool> settings = snapshot.data;
            notifications = settings[0];
            phone = settings[1];
            backup = settings[2];

            return Scaffold(
              backgroundColor: colours.black(),
              body: Padding(
                padding: EdgeInsets.only(left: sizes.height(context, 32), right: sizes.height(context, 14)),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes.height(context, 28)),
                        GestureDetector(
                          onTap: () {
                            saveSettings();
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_outlined,
                            size: 36,
                            color: colours.white(),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 40)),

                        Text(
                          'Settings',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: colours.white(),
                            fontFamily: 'ProductSans',
                            fontSize: 64,
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 24)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'general',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: colours.white(opacity: .7),
                                fontFamily: 'ProductSans',
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/notification.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'notifications',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      notifications ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: notifications,
                                        onToggle: (val) {
                                          setState(() {
                                            notifications = val;
                                            if(notifications) {
                                              CustomDialogs().areYouSure(context, sizes, colours);
                                            }
                                            else {
                                              Util().setDndFilter();
                                            }
                                            saveSettings();
                                          });
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: sizes.height(context, 36)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/phone.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'phone ringtone',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      phone ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: phone,
                                        onToggle: (val) {
                                          setState(() {
                                            phone = val;
                                            if(phone) {
                                              CustomDialogs().areYouSure(context, sizes, colours);
                                            }
                                            else {
                                              Util().setDndFilter();
                                            }
                                            saveSettings();
                                          });
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: sizes.height(context, 36)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/backup.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'backup',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      backup ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: backup,
                                        onToggle: (val) {
                                          setState(() {
                                            backup = val;
                                            saveSettings();
                                          });
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ), // general
                        SizedBox(height: sizes.height(context, 36)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'modes',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: colours.white(opacity: .7),
                                fontFamily: 'ProductSans',
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),

                            GestureDetector(
                              onTap: () {
                                saveSettings();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return FocusModeSettings();
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage('assets/watch.png'),
                                        fit: BoxFit.fill,
                                        width: 30,
                                        color: colours.white(),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(
                                        'focus mode',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: colours.white(),
                                            fontFamily: 'ProductSans'
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: sizes.width(context, 48),
                                    height: sizes.height(context, 54),
                                    decoration: BoxDecoration(
                                      color: colours.white(opacity: .9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: colours.black(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/danger.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'total shutdown',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: sizes.width(context, 48),
                                  height: sizes.height(context, 54),
                                  decoration: BoxDecoration(
                                    color: colours.white(opacity: .9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20,
                                      color: colours.black(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ), // modes
                        SizedBox(height: sizes.height(context, 54)),

                        Center(
                          child: Text(
                            'v0.0.1',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                        Center(
                          child: Text(
                            'com.jain.kaze',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                        Center(
                          child: Text(
                            'developed by Jain Corp',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return Scaffold(
              backgroundColor: colours.black(),
              body: Padding(
                padding: EdgeInsets.only(left: sizes.height(context, 32), right: sizes.height(context, 14)),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes.height(context, 28)),
                        GestureDetector(
                          onTap: () {
                            saveSettings();
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_outlined,
                            size: 36,
                            color: colours.white(),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 40)),

                        Text(
                          'Settings',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: colours.white(),
                            fontFamily: 'ProductSans',
                            fontSize: 64,
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 24)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'general',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: colours.white(opacity: .7),
                                fontFamily: 'ProductSans',
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/notification.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'notifications',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      notifications ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: notifications,
                                        onToggle: (val) {
                                          setState(() {
                                            notifications = val;
                                            if(notifications) {
                                              CustomDialogs().areYouSure(context, sizes, colours);
                                            }
                                            else {
                                              Util().setDndFilter();
                                            }
                                          });
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: sizes.height(context, 36)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/phone.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'phone ringtone',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      phone ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: phone,
                                        onToggle: (val) {
                                          setState(() {
                                            phone = val;
                                          });
                                          if(phone) {
                                            CustomDialogs().areYouSure(context, sizes, colours);
                                          }
                                          else {
                                            Util().setDndFilter();
                                          }
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: sizes.height(context, 36)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/backup.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'backup',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      backup ? 'on' : 'off',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colours.white(opacity: .6),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                        width: sizes.width(context, 64),
                                        height: sizes.height(context, 54),
                                        toggleSize: sizes.height(context, 42),
                                        borderRadius: 16,
                                        showOnOff: false,
                                        activeColor: Color(0xFF393e46),
                                        inactiveColor: colours.white(),
                                        activeTextColor: colours.white(),
                                        inactiveToggleColor: Color(0xFF3C3C3C),
                                        value: backup,
                                        onToggle: (val) {
                                          setState(() {
                                            backup = val;
                                          });
                                          initGoogleSigning(backup);
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ), // general
                        SizedBox(height: sizes.height(context, 36)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'modes',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: colours.white(opacity: .7),
                                fontFamily: 'ProductSans',
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),

                            GestureDetector(
                              onTap: () {
                                saveSettings();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return FocusModeSettings();
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage('assets/watch.png'),
                                        fit: BoxFit.fill,
                                        width: 30,
                                        color: colours.white(),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(
                                        'focus mode',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: colours.white(),
                                            fontFamily: 'ProductSans'
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: sizes.width(context, 48),
                                    height: sizes.height(context, 54),
                                    decoration: BoxDecoration(
                                      color: colours.white(opacity: .9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: colours.black(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: sizes.height(context, 42)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/danger.png'),
                                      fit: BoxFit.fill,
                                      width: 30,
                                      color: colours.white(),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      'total shutdown',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: colours.white(),
                                          fontFamily: 'ProductSans'
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: sizes.width(context, 48),
                                  height: sizes.height(context, 54),
                                  decoration: BoxDecoration(
                                    color: colours.white(opacity: .9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20,
                                      color: colours.black(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ), // modes
                        SizedBox(height: sizes.height(context, 54)),

                        Center(
                          child: Text(
                            'v0.0.1',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                        Center(
                          child: Text(
                            'com.jain.kaze',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                        Center(
                          child: Text(
                            'developed by Jain Corp',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: colours.white(opacity: .7),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height(context, 8)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }


  Future<bool> _androidBack(BuildContext context) async {
    saveSettings();
    Navigator.of(context).pop();
    return true;
  }

  void saveSettings() async {
    await SettingsService().setSettings(notifications, phone, backup);
  }

  void initGoogleSigning(bool backup) async {
    if(backup) {
      UserCredential userCred = await Util().signInWithGoogle();
      await ModeService().backup(userCred.user);
    }
  }
}

class FocusModeSettings extends StatefulWidget {
  FocusModeSettings({Key key}) : super(key: key);

  @override
  _FocusModeSettingsState createState() => _FocusModeSettingsState();
}

class _FocusModeSettingsState extends State<FocusModeSettings> {
  Sizes sizes = Sizes();
  Colours colours = Colours();

  ValueNotifier<List<String>> selectedApps = ValueNotifier([]);

  @override
  void dispose() {
    selectedApps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SettingsService().getFocusModeApps(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // selectedApps = ValueNotifier(snapshot.data);
          print("focus hai");
          print("valueNot: " + selectedApps.value.toString());
          return Scaffold(
            backgroundColor: colours.black(),
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sizes.height(context, 48)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 36,
                          color: colours.white(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          SettingsService().setFocusModeApps(selectedApps.value);
                          // todo toast
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                          log("done");
                        },
                        child: Image(
                          image: AssetImage('assets/done.png'),
                          width: 42,
                          color: colours.white(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: sizes.height(context, 36)),

                  Text(
                    'Focus Mode',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colours.white(),
                      fontFamily: 'ProductSans',
                      fontSize: 64,
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 24)),
                  Text(
                    '2 apps you need in focus mode',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colours.white(opacity: .7),
                      fontFamily: 'ProductSans',
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 32)),

                  FutureBuilder(
                      future: Util().getAllApps(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          List allApps = snapshot.data;
                          return SizedBox(
                            width: sizes.width(context, 414),
                            height: sizes.height(context, 568),
                            child: ListView.builder(
                              itemCount: allApps.length,
                              itemBuilder: (context, index) {
                                Map app = allApps[index];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: sizes.width(context, 36),
                                              height: sizes.height(context, 48),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colours.white()
                                              ),
                                              child: Image(
                                                image: MemoryImage(app["icon"]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              app["label"],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'ProductSans',
                                                  color: colours.white()
                                              ),
                                            ),
                                          ],
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: selectedApps,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                if(selectedApps.value.length == 2 && selectedApps.value.contains(app["package"])) {
                                                  selectedApps.value.remove(app["package"]);
                                                  print("newSelectedApps is removed");
                                                }
                                                else if (selectedApps.value.length >= 2) {
                                                  // todo: toast
                                                  print("newSelectedApps os greater than 2");
                                                }
                                                else {
                                                  if (selectedApps.value.contains(app["package"])) {
                                                    selectedApps.value.remove(app["package"]);
                                                    print("newSelectedApps is removed");
                                                  }
                                                  else {
                                                    selectedApps.value.add(app["package"]);
                                                    print("newSelectedApps is added");
                                                  }
                                                }
                                                selectedApps.notifyListeners();
                                                // selectedApps = ValueNotifier(selectedApps.value);
                                                // print("lenNew: " + newSelectedApps.length.toString());
                                                print("lenOld: " + selectedApps.value.length.toString());
                                              },
                                              child: Container(
                                                width: sizes.width(context, 48),
                                                height: sizes.height(context, 54),
                                                decoration: BoxDecoration(
                                                    color: selectedApps.value.contains(app["package"]) ? colours.white() : Colors.transparent,
                                                    border: Border.all(color: colours.white(), width: 3)
                                                ),
                                              ),
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 32),
                                  ],
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
            ),
          );
        }
        else {
          return Scaffold(
            backgroundColor: colours.black(),
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sizes.height(context, 48)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 36,
                          color: colours.white(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          SettingsService().setFocusModeApps(selectedApps.value);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                        },
                        child: Image(
                          image: AssetImage('assets/done.png'),
                          width: 42,
                          color: colours.white(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: sizes.height(context, 36)),

                  Text(
                    'Focus Mode',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colours.white(),
                      fontFamily: 'ProductSans',
                      fontSize: 64,
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 24)),
                  Text(
                    '2 apps you need in focus mode',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colours.white(opacity: .7),
                      fontFamily: 'ProductSans',
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 32)),

                  FutureBuilder(
                      future: Util().getAllApps(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          List allApps = snapshot.data;
                          return ValueListenableBuilder(
                            valueListenable: selectedApps,
                            builder: (context, value, child) {
                              List<String> newSelectedApps = value;
                              return SizedBox(
                                width: sizes.width(context, 414),
                                height: sizes.height(context, 568),
                                child: ListView.builder(
                                  itemCount: allApps.length,
                                  itemBuilder: (context, index) {
                                    Map app = allApps[index];
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: sizes.width(context, 36),
                                                  height: sizes.height(context, 48),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colours.white()
                                                  ),
                                                  child: Image(
                                                    image: MemoryImage(app["icon"]),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  app["label"],
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'ProductSans',
                                                      color: colours.white()
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if(selectedApps.value.length == 2 && selectedApps.value.contains(app["package"])) {
                                                  selectedApps.value.remove(app["package"]);
                                                  print("newSelectedApps is removed");
                                                }
                                                else if (selectedApps.value.length >= 2) {
                                                  // todo: toast
                                                  print("newSelectedApps os greater than 2");
                                                }
                                                else {
                                                  if (selectedApps.value.contains(app["package"])) {
                                                    selectedApps.value.remove(app["package"]);
                                                    print("newSelectedApps is removed");
                                                  }
                                                  else {
                                                    selectedApps.value.add(app["package"]);
                                                    print("newSelectedApps is added");
                                                  }
                                                }
                                                selectedApps = ValueNotifier(selectedApps.value);

                                                selectedApps.notifyListeners();
                                                print("lenNew: " + newSelectedApps.length.toString());
                                                print("lenOld: " + selectedApps.value.length.toString());
                                              },
                                              child: Container(
                                                width: sizes.width(context, 48),
                                                height: sizes.height(context, 54),
                                                decoration: BoxDecoration(
                                                    color: newSelectedApps.contains(app["package"]) ? colours.white() : Colors.transparent,
                                                    border: Border.all(color: colours.white(), width: 3)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 32),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          );
                        }
                        else {
                          return SizedBox();
                        }
                      }
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}

