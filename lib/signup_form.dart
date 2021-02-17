import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AuthFormAppointer extends StatefulWidget {
  AuthFormAppointer(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;

  final void Function(
    String email,
    String password,
    String userName,
    String phn,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormAppointerState createState() => _AuthFormAppointerState();
}

class _AuthFormAppointerState extends State<AuthFormAppointer> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _phn = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _phn.trim(),
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          SizedBox(
  width: 250.0,
  child: Center(
    child: TyperAnimatedTextKit(
      speed:Duration(milliseconds:250),
      text: [
        "Welcome!",
        "Welcome!",
        "Welcome!",
        
      ],
      textStyle: TextStyle(
          fontSize: 34.0,
          fontFamily: "Bobbers"
      ),
      textAlign: TextAlign.start,
    ),
  ),
),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Center(
            child: Card(
              shadowColor: Colors.green[800],
              elevation: MediaQuery.of(context).size.height * 0.04,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          cursorColor: Colors.deepPurple,
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              labelText: 'Email address',
                              labelStyle: TextStyle(color: Colors.grey[600])),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.grey[600])),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                        TextFormField(
                          key: ValueKey('phn'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              labelText: 'Phone No.',
                              labelStyle: TextStyle(color: Colors.grey[600])),
                          onSaved: (value) {
                            _phn = value;
                          },
                        ),
                    
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey[600])),
                          obscureText: true,
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                        SizedBox(height: 12),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          RaisedButton(
                            elevation: 6.0,
                            color: Colors.green[800],
                            textColor: Colors.white,
                            child: Text('Signup'),
                            onPressed: _trySubmit,
                          ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

