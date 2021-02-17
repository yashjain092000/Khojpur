import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                  ),
                ),
                Text(
                  "APPOINT",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                RotateAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  isRepeatingAnimation: true,

                  //totalRepeatCount: 3,
                  text: [
                    "KHOJPUR",
                    "KHOJPUR",
                    "KHOJPUR",
                    "KHOJPUR",
                  ],
                  // alignment: Alignment(1.0, 0.5),
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w900,
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Text(
                        "One place where you can ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(children: <Widget>[
                      Text(
                        "Book your appointments",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(children: <Widget>[
                      Text(
                        "Manage your appointments",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(children: <Widget>[
                      Text(
                        "Get your appointments booked",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 220),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Divider(thickness: 0.4, color: Colors.deepPurple),
              ),
              Center(child: Text("Developed with")),
              Center(child: Text("❤")),
              Center(child: Text("by")),
              Center(child: Text("Yash & Mukul")),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Divider(thickness: 0.4, color: Colors.deepPurple),
              ),
            ],
          ),
        ],
      ),
    );
  }
}