import 'package:Khojpur/item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> d = [];
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

class LostScreen extends StatefulWidget {
  @override
  _LostScreenState createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  String _selectedPlace = "";
  String _selectedItem = "";
  String currentMail = "";

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
            /*RaisedButton(
                color: Colors.white, child: Text("Submit"), onPressed: addItem),
            //),*/
            SizedBox(height: 10),
            Expanded(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('found_reports')
                        .snapshots(),
                    builder: (ctx, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final docu = streamSnapshot.data.documents;
                      List<Item> ab = [];
                      for (int i = 0; i < docu.length; i++) {
                        if (_selectedPlace.compareTo(docu[i]['place']) == 0 &&
                            _selectedItem.compareTo(docu[i]['item']) == 0) {
                          ab.add(Item(docu[i]['place'], docu[i]['item'],
                              docu[i]['date'], docu[i]["itemName"]));
                        }
                      }
                      //deleteDuplicateItem(ab);
                      return GridView.builder(
                          itemCount: ab.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.65),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Card(child: Text(ab[index].item)),
                                  Card(child: Text(ab[index].place)),
                                  Card(child: Text(ab[index].itemName)),
                                  Card(
                                    color: Colors.green,
                                    child: FlatButton(
                                        //color: Colors.green,
                                        child: Text("place an Claim request"),
                                        onPressed: () => Firestore.instance
                                                .collection("claim_requests")
                                                .document()
                                                .setData({
                                              "itemName": ab[index].itemName,
                                              "item": ab[index].item,
                                              "place": ab[index].place,
                                              "user_email": currentMail,
                                              "date": DateTime.now().toString()
                                            })),
                                  ),
                                  Card(
                                      child: FlatButton(
                                          child: Text("who claimed"),
                                          onPressed: () {
                                            Firestore.instance
                                                .collection("claim_requests")
                                                .getDocuments()
                                                .then((QuerySnapshot snapshot) {
                                              for (int i = 0;
                                                  i < snapshot.documents.length;
                                                  i++) {
                                                if (snapshot.documents[i]
                                                            ['itemName']
                                                        .compareTo(ab[index]
                                                            .itemName) ==
                                                    0) {
                                                  snapshot
                                                      .documents[i].documentID;
                                                  d.add(snapshot
                                                      .documents[i].documentID);
                                                }
                                              }
                                            });
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (_) {
                                                  return ListView.builder(
                                                      itemCount: d.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                            child:
                                                                Text(d[index]));
                                                      });
                                                });
                                          }))
                                ],
                              ),
                            );
                          });
                    })),
          ],
        ),
      ),
    );
  }
}
