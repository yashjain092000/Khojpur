//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
import 'new_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPicker extends StatefulWidget {
  @override
  _DashboardPickerState createState() => _DashboardPickerState();
}

class _DashboardPickerState extends State<DashboardPicker> {
  String _usermail = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUserMail() async {
    final FirebaseUser user = await auth.currentUser();
    final uemail = user.email;
    setState(() {
      _usermail = uemail;
    });
  }
  /* _getUserName() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _usertype = value.data['email'];
      });
    });
  }*/

  void initState() {
    super.initState();
    getCurrentUserMail();
  }

  @override
  Widget build(BuildContext context) {
    return _usermail.compareTo("master@gmail.com") == 0
        ? NewDashboard()
        : Dashboard();
  }
}
