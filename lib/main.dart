import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaze/screens/home.dart';
import 'package:kaze/screens/onboarding.dart';
import 'package:kaze/services/notifications.dart';
import 'package:kaze/services/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Firebase.initializeApp();
  runApp(Kaze());
}

class Kaze extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaze',
      theme: ThemeData(
        primaryColor: Color(0xFF1B1A17),
        accentColor: Color(0xFFF2F4F4),
      ),
      home: doesUserExist(),
    );
  }
}

class doesUserExist extends StatelessWidget {
  const doesUserExist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: User().getUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Home();
        }
        else {
          return Onboarding();
        }
      }
    );
  }
}

