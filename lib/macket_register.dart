import 'package:flutter/material.dart';
class MackgetRegisterPage extends StatefulWidget {
  @override
  _MackgetRegisterPageState createState() => _MackgetRegisterPageState();
}

class _MackgetRegisterPageState extends State<MackgetRegisterPage> {

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('입점 문의'),
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