import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String userPhone,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userPhone = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _userPhone.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 160.0),
          TypewriterAnimatedTextKit(
              speed: Duration(milliseconds: 300),
              totalRepeatCount: 0,
              text: [_isLogin ? "Welcome Back!" : "Welcome!!"],
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "Agne",
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart),
          SizedBox(height: 60.0),
          Center(
            child: Card(
              elevation: 20.0,
              color: Colors.yellow,
              shadowColor: Colors.black,
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email address',
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Username'),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('phone_no.'),
                            validator: (value) {
                              if (value.isEmpty || value.length != 10) {
                                return 'invalid phone no.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Phone No.'),
                            obscureText: true,
                            onSaved: (value) {
                              _userPhone = value;
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
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                        SizedBox(height: 12),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          RaisedButton(
                            elevation: 9.0,
                            color: Colors.green,
                            child: Text(
                              _isLogin ? 'Login' : 'Signup',
                              style: TextStyle(
                                color: Colors.yellow,
                              ),
                            ),
                            onPressed: _trySubmit,
                          ),
                        if (!widget.isLoading)
                          FlatButton(
                            textColor: Colors.green,
                            child: Text(
                              _isLogin
                                  ? 'Create new account'
                                  : 'I already have an account',
                            ),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                          )
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
