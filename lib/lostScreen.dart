import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LostScreen extends StatefulWidget {
  @override
  _LostScreenState createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  //String _selectedPlace = "";
  //String _selectedItem = "";
  String currentMail = "";
  String _itemDescription = "";

  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentMail() async {
    final FirebaseUser user = await auth.currentUser();
    final uemail = user.email;
    setState(() {
      currentMail = uemail;
    });
    print(currentMail);
  }

  void initState() {
    super.initState();
    getCurrentMail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lost Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            SizedBox(height: 10),
            Card(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _itemDescription = value;
                  });
                },
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    labelText: "itemDescription",
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
            ),
            Card(
              color: Colors.amber[300],
              child: FlatButton(
                  onPressed: () {
                    Firestore.instance
                        .collection("lost_messages")
                        .document()
                        .setData(
                            {"message": _itemDescription, "mail": currentMail});
                  },
                  child: Text("upload")),
            )
          ],
        ),
      ),
    );
  }
}
