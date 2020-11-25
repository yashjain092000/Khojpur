import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'auth_screen.dart';
import 'new_auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      }
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Transform.rotate(
                    angle: animation.value * 6.3,
                    child: Image(
                      image: AssetImage('images/logo.png'),
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: ColorizeAnimatedTextKit(
                      onTap: () {
                        // WavyAnimatedTextKit(
                        //   textStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 32.0,
                        //       fontWeight: FontWeight.bold),
                        //   text: ["KHOJPUR"],
                        //   isRepeatingAnimation: true,
                        // );
                      },
                      isRepeatingAnimation: true,
                      text: ["KHOJPUR"],
                      textStyle:
                          TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                      colors: [
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      SizedBox(height: 70),
                      Text(
                        "One place where you can ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
                    SizedBox(height: 30),
                    Row(children: <Widget>[
                      Text(
                        "File found report",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                    SizedBox(height: 14),
                    Row(children: <Widget>[
                      Text(
                        "Publish lost item notice",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                    SizedBox(height: 14),
                    Row(children: <Widget>[
                      Text(
                        "Claim found items",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewAuthScreen()),
              );
            },
            child: Text('Master Login'),
          ),
        ],
      ),
    );
  }
}
