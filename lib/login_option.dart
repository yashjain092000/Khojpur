import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Existing user?",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF3F6826),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF3F6826),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF3F6826).withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFECCB45),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
