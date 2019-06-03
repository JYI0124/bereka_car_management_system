import 'package:flutter/material.dart';
class MyUsagePage extends StatefulWidget {
  @override
  _MyUsagePageState createState() => _MyUsagePageState();
}

class _MyUsagePageState extends State<MyUsagePage> {

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('이용내역'),
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