import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'new_auth_form.dart';

class NewAuthScreen extends StatefulWidget {
  @override
  _NewAuthScreenState createState() => _NewAuthScreenState();
}

class _NewAuthScreenState extends State<NewAuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: NewAuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
