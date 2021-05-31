import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaze/screens/focus.dart';
import 'package:kaze/screens/home.dart';
import 'package:kaze/screens/settings.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';

import 'colours.dart';
import 'sizes.dart';

class CustomDialogs {
  void category(context, Sizes sizes, Colours colours, {String title = ""}) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 375),
            height: sizes.height(context, 360),
            decoration: BoxDecoration(
              color: colours.white(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: sizes.height(context, 20)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Settings();
                          },
                        ),
                      );
                      FirebaseAnalytics().logEvent(name: "clicked_on_settings");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: 'ProductSans',
                            color: colours.black(),
                            decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: colours.black(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 20)),
                  GestureDetector(
                    onTap: () {
                      focusMode(context, sizes, colours);
                      FirebaseAnalytics().logEvent(name: "clicked_start_focus_mode");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Start Focus Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'ProductSans',
                              color: colours.black(),
                              decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: colours.black(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 20)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AllApps();
                          },
                        ),
                      );
                      FirebaseAnalytics().logEvent(name: "clicked_all_apps");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'See All Apps',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'ProductSans',
                              color: colours.black(),
                              decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: colours.black(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 20)),
                  GestureDetector(
                    onTap: () {
                      title != null ? areYouSureModeDelete(context, sizes, colours, title) : print("title is null");
                      FirebaseAnalytics().logEvent(name: "clicked_delete_mode");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delete $title mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'ProductSans',
                              color: Color(0xFF962D2D),
                              decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: Color(0xFF962D2D),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 20)),
                  GestureDetector(
                    onTap: () {
                      areYouSureQuitKaze(context, sizes, colours);
                      FirebaseAnalytics().logEvent(name: "clicked_quit_kaze");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quit Kaze',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'ProductSans',
                              color: Color(0xFF962D2D),
                              decoration: TextDecoration.none
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 32,
                          color: Color(0xFF962D2D),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: sizes.height(context, 12)),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void focusMode(context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 205),
            decoration: BoxDecoration(
              color: colours.white(),
              border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Start Focus Mode?',
                  style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 32,
                    color: colours.black(),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  'in focus mode, you will be able to use only 2 apps\n  of your choice, you can exit it whenever you want',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: .65,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 32),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FocusMode();
                                },
                              ),
                            );
                            FirebaseAnalytics().logEvent(name: "went_to_focus_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                              color: colours.black(),
                              border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "did_not_go_focus_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void openApp(context, Sizes sizes, Colours colours, Map app) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                SizedBox(
                  width: sizes.width(context, 310),
                  child: Center(
                    child: Text(
                      'Open ' + app["label"] + '?',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 32,
                          color: colours.black(),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "the time right now, doesn't align with the mode's.\nDo you want to use the app anyway or wait?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openAppSecondary(context, sizes, colours, app);
                            FirebaseAnalytics().logEvent(name: "went_open_app_secondary");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_to_home");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void openAppSecondary(context, Sizes sizes, Colours colours, Map app) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "the time right now, doesn't align with the mode's.\nDo you want to use the app anyway or wait?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Util().openApp(app["package"]);
                            FirebaseAnalytics().logEvent(name: "opened_app");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_to_open_app");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSure(BuildContext context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "you will be sent notifications from other apps and\nyou might be distracted and be unable to focus",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Util().setDndFilter(dnd: 2);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Settings();
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSureFocus(BuildContext context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "this will switch off focus mode and you might be\ndistracted and be unable to focus, so are you sure?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            areYouSureFocusSecondary(context, sizes, colours);
                            FirebaseAnalytics().logEvent(name: "went_focus_mode_secondary");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_to_focus_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSureFocusSecondary(BuildContext context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Leave Focus Mode?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "this will switch off focus and you might be\ndistracted and be unable to focus, so are you sure?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            areYouSureFocusThird(context, sizes, colours);
                            FirebaseAnalytics().logEvent(name: "went_focus_mode_third");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_focus_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSureFocusThird(BuildContext context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Exit Focus Mode?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "we are repeatedly asking you to help you resist the urge of using your phone, please don't take it in any other context",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Util().setDndFilter();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home();
                                },
                              ),
                            );
                            FirebaseAnalytics().logEvent(name: "exited_focus_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_focus_mode_secondary");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSureModeDelete(BuildContext context, Sizes sizes, Colours colours, title) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "you will not be able to get this mode back\nonce it is deleted,you will have to recreate it",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ModeService().deleteMode(title);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home();
                                },
                              ),
                            );
                            FirebaseAnalytics().logEvent(name: "deleted_mode");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_main_category");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void areYouSureQuitKaze(BuildContext context, Sizes sizes, Colours colours) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: sizes.width(context, 335),
            height: sizes.height(context, 225),
            decoration: BoxDecoration(
                color: colours.white(),
                border: Border.all(color: colours.black(), width: 3)
            ),
            child: Column(
              children: [
                SizedBox(height: sizes.height(context, 16),),
                Text(
                  'Exit Kaze Launcher?',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 32,
                      color: colours.black(),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 12),),
                Text(
                  "by exiting kaze launcher, we will no longer be the primary\nlauncher app for you phone, you can make us primary again",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      height: 1.3,
                      color: colours.black(opacity: .8),
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: sizes.height(context, 36),),

                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Util().removeLauncherDefault();
                            SystemNavigator.pop();
                            FirebaseAnalytics().logEvent(name: "exited_kaze");
                          },
                          child: Container(
                            width: sizes.width(context, 110),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: colours.black(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAnalytics().logEvent(name: "went_back_focus_mode_secondary");
                          },
                          child: Container(
                            width: sizes.width(context, 95),
                            height: sizes.height(context, 48),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
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
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}