import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NewAuthForm extends StatefulWidget {
  NewAuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) submitFn;

  @override
  _NewAuthFormState createState() => _NewAuthFormState();
}

class _NewAuthFormState extends State<NewAuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            SizedBox(height: 60.0),
            TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 300),
                totalRepeatCount: 0,
                text: ["Welcome Back!"],
                textStyle: TextStyle(
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
                              child: Text('Login'),
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
      ),
    );
  }
}
