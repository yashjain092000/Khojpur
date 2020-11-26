import 'package:Khojpur/foundScreen.dart';
import 'package:Khojpur/lostScreen.dart';
//import 'package:Khojpur/picker/foundItem_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';

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

class NewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidApp(
      materialApp: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Khojpur',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NewDashboardPage(title: 'NewDashboard'),
      ),
    );
  }
}

class NewDashboardPage extends StatefulWidget {
  NewDashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewDashboardPageState createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  String _selectedPlace = "";
  String _selectedItem = "";
  String currentMail = "";
  //int _counter = 0;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUserMail() async {
    final FirebaseUser user = await auth.currentUser();
    final uemail = user.email;
    setState(() {
      currentMail = uemail;
    });
  }

  void initState() {
    super.initState();
    getCurrentUserMail();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _endSideMenuKey,
      inverse: true, // end side menu
      background: Colors.green[700],
      type: SideMenuType.slideNRotate,
      menu: buildMenu(),
      child: SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  final _state = _sideMenuKey.currentState;
                  if (_state.isOpened)
                    _state.closeSideMenu();
                  else
                    _state.openSideMenu();
                },
              ),
              title: Text(widget.title),
              actions: [
                DropdownButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                      value: 'logout',
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
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
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
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
                            List<Item> abc = [];
                            for (int i = 0; i < docu.length; i++) {
                              if (_selectedPlace.compareTo(docu[i]['place']) ==
                                      0 &&
                                  _selectedItem.compareTo(docu[i]['item']) ==
                                      0) {
                                abc.add(Item(
                                    docu[i]['place'],
                                    docu[i]['item'],
                                    docu[i]['date'],
                                    docu[i]["itemName"],
                                    docu[i]["Item_image"],
                                    docu[i]["id"]));
                                //String b = docu[i].
                              }
                            }
                            //deleteDuplicateItem(ab);
                            return GridView.builder(
                                itemCount: abc.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        childAspectRatio: 0.65),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    abc[index].image),
                                              ),
                                            ),
                                          ),
                                          Card(child: Text(abc[index].item)),
                                          Card(child: Text(abc[index].place)),
                                          Card(
                                              child: Text(abc[index].itemName)),
                                          Card(
                                            color: Colors.green,
                                            child: FlatButton(
                                                //color: Colors.green,
                                                child: Text(
                                                    "place an Claim request"),
                                                onPressed: () => Firestore
                                                        .instance
                                                        .collection(
                                                            "claim_requests")
                                                        .document()
                                                        .setData({
                                                      "itemName":
                                                          abc[index].itemName,
                                                      "item": abc[index].item,
                                                      "place": abc[index].place,
                                                      "user_email": currentMail,
                                                      "date": DateTime.now()
                                                          .toString()
                                                    })),
                                          ),
                                          FlatButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (_) {
                                                      return StreamBuilder(
                                                          stream: Firestore
                                                              .instance
                                                              .collection(
                                                                  'claim_requests')
                                                              .snapshots(),
                                                          builder: (ctx,
                                                              streamSnapshot) {
                                                            if (streamSnapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                            final doc =
                                                                streamSnapshot
                                                                    .data
                                                                    .documents;
                                                            List<String> c = [];
                                                            for (int i = 0;
                                                                i < doc.length;
                                                                i++) {
                                                              if (doc[i]["itemName"].compareTo(abc[index].itemName) == 0 &&
                                                                  doc[i]["item"].compareTo(
                                                                          abc[index]
                                                                              .item) ==
                                                                      0 &&
                                                                  doc[i]["place"]
                                                                          .compareTo(
                                                                              abc[index].place) ==
                                                                      0) {
                                                                c.add(doc[i][
                                                                    "user_email"]);
                                                              }
                                                            }
                                                            return ListView
                                                                .builder(
                                                                    itemCount: c
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            indexA) {
                                                                      return ListTile(
                                                                        title: Text(
                                                                            c[indexA]),
                                                                        trailing: FlatButton(
                                                                            onPressed: () {
                                                                              Firestore.instance.collection("claimed_items").document().setData({
                                                                                "itemName": abc[index].itemName,
                                                                                "item": abc[index].item,
                                                                                "place": abc[index].place,
                                                                                "user_claimed": c[indexA],
                                                                                "date": DateTime.now().toString()
                                                                              });
                                                                              Firestore.instance.collection("found_reports").document(abc[index].id).delete();
                                                                            },
                                                                            child: Text("give_claim")),
                                                                      );
                                                                    });
                                                          });
                                                    });
                                              },
                                              child: Text("who claimed"))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('lost_messages')
                            .snapshots(),
                        builder: (ctx, streamSnapshot) {
                          if (streamSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final doc = streamSnapshot.data.documents;
                          List<String> cd = [];
                          for (int i = 0; i < doc.length; i++) {
                            cd.add(doc[i]["message"] +
                                "  mail :" +
                                doc[i]["mail"]);
                          }
                          return ListView.builder(
                              itemCount: cd.length,
                              itemBuilder: (context, index) {
                                return Card(child: Text(cd[index]));
                              });
                        },
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                LText(
                  "\l.lead{Hello},\n\l.lead.bold{Johnie}",
                  baseStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {},
            leading:
                Icon(Icons.account_circle, size: 20.0, color: Colors.white),
            title: Text("Profile"),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LostScreen()),
              );
            },
            leading: Icon(Icons.search, size: 20.0, color: Colors.white),
            title: Text("Lost Screen"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoundScreen()),
              );
            },
            leading: Icon(Icons.help_outline_rounded,
                size: 20.0, color: Colors.white),
            title: Text("Found Screen"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {},
            leading: Icon(Icons.done_all, size: 20.0, color: Colors.white),
            title: Text("Claimed"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
