import 'package:Khojpur/picker/foundItem_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> ddl = ["item_1", 'item_2', 'item_3'];
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

List<DropdownMenuItem<String>> _dropDownPlaceItem() {
  List<String> ddl = ["place_1", 'place_2', 'place_3'];
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

class FoundScreen extends StatefulWidget {
  @override
  _FoundScreenState createState() => _FoundScreenState();
}

class _FoundScreenState extends State<FoundScreen> {
  String _selectedPlace = "";
  String _selectedItem = "";
  String _currentMail = "";
  String _itemName = "";
  String _itemDescription = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentMail() async {
    final FirebaseUser user = await auth.currentUser();
    final uemail = user.email;
    setState(() {
      _currentMail = uemail;
    });
    //print(_currentMail);
  }

  void initState() {
    super.initState();
    getCurrentMail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found Screen"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              elevation: 0,
              // value: _selectedGender,
              items: _dropDownPlaceItem(),
              hint: Text("place",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[600])),
              onChanged: (value) {
                _selectedPlace = value;
                setState(() {
                  _selectedPlace = value;
                });
              },
            ),
            /*Card(
              child: */
            DropdownButton(
              elevation: 0,
              // value: _selectedGender,
              items: _dropDownItem(),
              hint: Text("Item",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[600])),
              onChanged: (value) {
                _selectedItem = value;
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
            Card(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _itemName = value;
                  });
                },
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    labelText: "itemname",
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
            ),
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
                child: FoundItemPicker(_selectedPlace, _selectedItem,
                    _currentMail, _itemName, _itemDescription)),
          ],
        ),
      ),
    );
  }
}
