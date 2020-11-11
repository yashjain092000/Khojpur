import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/registration_screen.dart';
import 'screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(Khojpur());

class Khojpur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              return ChatScreen();
            } else {
              return WelcomeScreen();
            }
          }),
    );
  }
}
