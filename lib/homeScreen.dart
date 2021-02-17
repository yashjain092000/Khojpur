import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "🏛️ Home",
          baseStyle:
              TextStyle(color: Colors.black, fontSize: 28.0),
              selectedStyle: TextStyle(color: Colors.green[800], fontSize: 28.0),
          colorLineSelected: Colors.black,
        ),
        WelcomeScreen()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "👤 Login",
          baseStyle:
              TextStyle(color: Colors.black, fontSize: 28.0),
                selectedStyle: TextStyle(color: Colors.green[800], fontSize: 28.0),
          colorLineSelected: Colors.black,
        ),
        LoginScreen()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "👥 Signup",
          baseStyle:
              TextStyle(color: Colors.black, fontSize: 28.0),
                selectedStyle: TextStyle(color: Colors.green[800], fontSize: 28.0),
          colorLineSelected: Colors.black,
        ),
        SignupScreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      elevationAppBar: 20.0,
      backgroundColorMenu: Colors.amberAccent[400],
      backgroundColorAppBar: Colors.green[800],
      screens: items,
    );
  }
}
