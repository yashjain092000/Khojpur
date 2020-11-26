import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoundItemPicker extends StatefulWidget {
  final String place;
  final String item;
  final String mail;
  final String itemName;
  final String itemDescription;
  FoundItemPicker(
      this.place, this.item, this.mail, this.itemName, this.itemDescription);
  @override
  _FoundItemPickerState createState() => _FoundItemPickerState();
}

class _FoundItemPickerState extends State<FoundItemPicker> {
  //String _currentUserEmail = "";
  File _pickedItemImage;
  final pick = ImagePicker();
  void _pickImage() async {
    final pickedImageFile = await pick.getImage(source: ImageSource.camera);
    setState(() {
      _pickedItemImage = File(pickedImageFile.path);
    });
    //print(widget.date);
  }

  void _pickImageThroughGallery() async {
    final pickedImageFile = await pick.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedItemImage = File(pickedImageFile.path);
    });
  }

  void _uploadImage() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("found_reorts_item_images")
        .child(widget.mail + DateTime.now().toString() + '.jpg');

    await ref.putFile(_pickedItemImage).onComplete;
    final profileImageUrl = await ref.getDownloadURL();
    Firestore.instance
        .collection("found_reports")
        .document(widget.mail + widget.itemName)
        .setData({
      "Item_image": profileImageUrl,
      "place": widget.place,
      "item": widget.item,
      "date": DateTime.now().toString(),
      "itemName": widget.itemName,
      "itemDescription": widget.itemDescription,
      "persons_mail": widget.mail,
      "id": widget.mail + widget.itemName
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedItemImage != null ? FileImage(_pickedItemImage) : null,
        ),
        FlatButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text("Add items image by camera")),
        FlatButton.icon(
            onPressed: _pickImageThroughGallery,
            icon: Icon(Icons.image),
            label: Text("Add items image by gallery")),
        RaisedButton(
            elevation: 9,
            color: Colors.yellow,
            onPressed: _uploadImage,
            child: Text("Upload report"))
      ],
    );
  }
}
