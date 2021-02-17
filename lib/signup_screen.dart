import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'signup_form.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    String phn,
    // int age,
    // String address,
    // String specialisation,
    // int fee,
    // int emFee,
    // String morTime1,
    // String morTime2,
    // String eveTime1,
    // String eveTime2,
    // int eachTime,
    // bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    //final ref = FirebaseStorage.instance.ref();
    try {
      setState(() {
        _isLoading = true;
      });
      // if (isLogin) {
      //   print("Appointee's signup");
      //   authResult = await _auth.createUserWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );

      //   await Firestore.instance
      //       .collection('users')
      //       .document(authResult.user.uid)
      //       .setData({
      //     'username': username,
      //     'email': email,
      //     'typeUser': 'Appointee',
      //     'profile_image': " "
      //   });
      //   await Firestore.instance
      //       .collection('Appointees')
      //       .document(authResult.user.uid)
      //       .setData({
      //     'userEmail': email,
      //     'username': username,
      //     'age': age,
      //     'phone no.': phn,
      //     'address': address,
      //     'password': password,
      //   });
      // } 
      // else {
      //   print("Appointer's signup");
      //   authResult = await _auth.createUserWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );

      //   await Firestore.instance
      //       .collection('users')
      //       .document(authResult.user.uid)
      //       .setData({
      //     'canBook': true,
      //     'username': username,
      //     'email': email,
      //     'typeUser': 'Appointer',
      //     'profile_image': " ",
      //   });
      //   await Firestore.instance
      //       .collection('Appointers')
      //       .document(authResult.user.uid)
      //       .setData({
      //     'canBook': true,
      //     'profile_image': " ",
      //     'username': username,
      //     'userEmail': email,
      //     'specialisation': specialisation,
      //     'phone_no': phn,
      //     'address': address,
      //     'normal_fee': fee,
      //     'emergency_fee': emFee,
      //     'morning_start_time': morTime1,
      //     'morning_end_time': morTime2,
      //     'evening_start_time': eveTime1,
      //     'evening_end_time': eveTime2,
      //     'patient_time': eachTime
      //   });
      // }
      authResult = await _auth.createUserWithEmailAndPassword(
           email: email,
           password: password,
         );

      await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'phone_no': phn,
         
        });

    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

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
      backgroundColor: Colors.white,
      body: AuthFormAppointer(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}