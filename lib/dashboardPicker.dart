import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
import 'new_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPicker extends StatefulWidget {
  @override
  _DashboardPickerState createState() => _DashboardPickerState();
}

class _DashboardPickerState extends State<DashboardPicker> {
  var _usertype;
  Future<void> _getUserName() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _usertype = value.data['email'].toString();
      });
    });
  }

  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return _usertype == "master@gmail.com" ? NewDashboard() : Dashboard();
  }
}
