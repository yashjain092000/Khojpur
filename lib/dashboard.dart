import 'package:Khojpur/foundScreen.dart';
import 'package:Khojpur/lostScreen.dart';
//import 'package:Khojpur/picker/foundItem_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'item.dart';
// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Khojpur'),
//         actions: [
//           DropdownButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Theme.of(context).primaryIconTheme.color,
//             ),
//             items: [
//               DropdownMenuItem(
//                 child: Container(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.exit_to_app),
//                       SizedBox(width: 8),
//                       Text('Logout'),
//                     ],
//                   ),
//                 ),
//                 value: 'logout',
//               ),
//             ],
//             onChanged: (itemIdentifier) {
//               if (itemIdentifier == 'logout') {
//                 FirebaseAuth.instance.signOut();
//               }
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Text("Hello!"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidApp(
      materialApp: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Khojpur',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DashboardPage(title: 'Dashboard'),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //int _counter = 0;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
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
            body: Text(
                "hello") /*StreamBuilder(
              stream:
                  Firestore.instance.collection('found_reports').snapshots(),
              builder: (ctx, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final docu = streamSnapshot.data.documents;
                List<Item> b = [];
                for (int i = 0; i < docu.length; i++) {
                  b.add(
                      Item(docu[i]['place'], docu[i]['item'], docu[i]['date']));
                }
                deleteDuplicateItem(b);
                return ListView.builder(
                    itemCount: b.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(b[index].item),
                            Text(b[index].place),
                            Text(b[index].date),
                          ],
                        ),
                      );
                    });
              }),*/
            ),
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
            leading: Icon(Icons.home, size: 20.0, color: Colors.white),
            title: Text("Home"),
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
            leading: Icon(Icons.verified_user, size: 20.0, color: Colors.white),
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
            leading:
                Icon(Icons.monetization_on, size: 20.0, color: Colors.white),
            title: Text("Found Screen"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {},
            leading: Icon(Icons.shopping_cart, size: 20.0, color: Colors.white),
            title: Text("Cart"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {},
            leading: Icon(Icons.star_border, size: 20.0, color: Colors.white),
            title: Text("Favorites"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {},
            leading: Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: Text("Settings"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
