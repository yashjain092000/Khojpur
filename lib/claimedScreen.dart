import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';

class ClaimedScreen extends StatefulWidget {
  @override
  _ClaimedScreenState createState() => _ClaimedScreenState();
}

class _ClaimedScreenState extends State<ClaimedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Claimed Items"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('claimed_items').snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docu = streamSnapshot.data.documents;
            List<Item> abcd = [];
            for (int i = 0; i < docu.length; i++) {
              abcd.add(Item(docu[i]['place'], docu[i]['item'], docu[i]['date'],
                  docu[i]["itemName"], docu[i]["user_claimed"], "hshshsh"));
              //String b = docu[i].
            }
            return ListView.builder(
                itemCount: abcd.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(abcd[index].itemName),
                    trailing: Text(abcd[index].image),
                  );
                });
          }),
    );
  }
}
