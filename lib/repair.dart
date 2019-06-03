import 'package:flutter/material.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {


  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('견적요청서'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          TextField(),
          TextField(),
          IconButton(
            icon: Icon(Icons.check),
            // onPressed: _getImageList,
          ),
        ],
      ),
    );
  }
}