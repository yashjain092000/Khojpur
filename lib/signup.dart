import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Sign up to",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF3D657),
            height: 2,
          ),
        ),
        Text(
          "KHOJPUR",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF3D657),
            letterSpacing: 2,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Enter Email / Username',
        //     hintStyle: TextStyle(
        //       fontSize: 16,
        //       color: Color(0xFF3F3C31),
        //       fontWeight: FontWeight.bold,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(25),
        //       borderSide: BorderSide(
        //         width: 0,
        //         style: BorderStyle.none,
        //       ),
        //     ),
        //     filled: true,
        //     fillColor: Colors.grey.withOpacity(0.1),
        //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        //   ),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Enter Username',
        //     hintStyle: TextStyle(
        //       fontSize: 16,
        //       color: Color(0xFF3F3C31),
        //       fontWeight: FontWeight.bold,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(25),
        //       borderSide: BorderSide(
        //         width: 0,
        //         style: BorderStyle.none,
        //       ),
        //     ),
        //     filled: true,
        //     fillColor: Colors.grey.withOpacity(0.1),
        //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        //   ),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Password',
        //     hintStyle: TextStyle(
        //       fontSize: 16,
        //       color: Color(0xFF3F3C31),
        //       fontWeight: FontWeight.bold,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(25),
        //       borderSide: BorderSide(
        //         width: 0,
        //         style: BorderStyle.none,
        //       ),
        //     ),
        //     filled: true,
        //     fillColor: Colors.grey.withOpacity(0.1),
        //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        //   ),
        // ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                ),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty || text.length < 6) {
                    return "Password shouldn't be empty or is too short";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                ),
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter username";
                  }
                  return null;
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // TODO submit
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFF3D657),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFF3D657).withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1C),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          "Or Signup with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF3D657),
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Entypo.facebook_with_circle,
              size: 32,
              color: Color(0xFFF3D657),
            ),
            SizedBox(
              width: 24,
            ),
            Icon(
              Entypo.google__with_circle,
              size: 32,
              color: Color(0xFFF3D657),
            ),
          ],
        )
      ],
    );
  }
}
