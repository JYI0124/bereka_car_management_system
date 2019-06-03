import 'package:flutter/material.dart';
class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('고객 지원 센터'),
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
        ],
      ),
    );
  }
}