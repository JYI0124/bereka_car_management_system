import 'user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'car.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class FeedbackPage extends StatefulWidget {
  User user;
  FeedbackPage(this.user);
  @override
  _FeedbackPageState createState() => _FeedbackPageState(user);
}

class _FeedbackPageState extends State<FeedbackPage> {
  User user;
  _FeedbackPageState(this.user);

  DateTime antifreeze = DateTime.now();
  String str_engine_oil;
  String str_image_url;
  String str_mission;
  String str_name;
  DateTime nextAntifreeze = DateTime.now();
  String str_next_engine_oil;
  String str_next_mission;
  String str_opinion;

  bool select1 =false;
  bool select2 =false;

  List<FocusNode> fnl = [FocusNode(),FocusNode(),FocusNode(),FocusNode(),FocusNode(),FocusNode()];

  Future<Null> selectAntifreeze(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: antifreeze,
        firstDate: DateTime(2019, 5),
        lastDate: DateTime(2040,5));
    if (picked != null && picked != antifreeze)
      setState(() {
        antifreeze = picked;
        select1 = true;
      });
  }
  Future<Null> selectNextAntifreeze(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: nextAntifreeze,
        firstDate: DateTime(2019, 5),
        lastDate: DateTime(2040,5));
    if (picked != null && picked != nextAntifreeze)
      setState(() {
        nextAntifreeze = picked;
        select2 = true;
      });
  }

  @override
  Widget build(BuildContext context) {


    /*
    Car car = getCar(
      antifreeze: DateTime.now(),
      engine_oil: 11000,
      image_url: 'image_url',
      mission: "mission",
      name: 'name',
      next_antifreeze: DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 1 * 1000*2592000),
      next_engine_oil: 16000,
      next_mission: 'next_mission',
      opinion: 'opinion'
    );

    // Timestamp.fromDate(c.next_antifreeze);

    */
    // document_ref.setData(
    // {'modified' : false,'creation' : Timestamp.now(),'edit' : Timestamp.now()});
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Car car =getCar(antifreeze: antifreeze, engine_oil: int.parse(str_engine_oil),image_url: '',mission: str_mission,name: str_name,next_antifreeze: nextAntifreeze,
              next_engine_oil: int.parse(str_next_engine_oil),next_mission: str_next_mission,opinion: str_opinion);
          car.reference.setData( {
            'antifreeze' : Timestamp.fromDate(car.antifreeze),
            'engine_oil' : car.engine_oil,
            'image_url' : car.image_url,
            'mission' : car.mission,
            'name' : car.name,
            'next_antifreeze' : Timestamp.fromDate(car.next_antifreeze),
            'next_engine_oil' : car.next_engine_oil,
            'next_mission' : car.next_mission,
            'opinion' : car.opinion,
          });

          final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(sampleImage.toString());
          final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
          task.onComplete.then((downLoadUrl) {
            downLoadUrl.ref.getDownloadURL().then((val) {
              car.reference.updateData(
                  {'image_url' : val});
            });
          });
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: 'name',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_name = text;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fnl[1]);
              },
              focusNode: fnl[0],
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'mission',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_mission = text;
              },
              focusNode: fnl[1],
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fnl[2]);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'next mission',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_next_mission = text;
              },
              focusNode: fnl[2],
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fnl[3]);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'engine oil',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_engine_oil = text;
              },
              keyboardType: TextInputType.number,
              focusNode: fnl[3],
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fnl[4]);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'next engine oil',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_next_engine_oil = text;
              },
              keyboardType: TextInputType.number,
              focusNode: fnl[4],
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fnl[5]);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'opinion',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
              ),
              onChanged: (text) {
                str_opinion = text;
              },
              focusNode: fnl[5],
            ),
            ButtonTheme(
              minWidth: 150.0,
              height: 30.0,
              child: RaisedButton(
                onPressed: () => selectAntifreeze(context),
                child: Text('select antifreeze date'),
                color: Theme.of(context).primaryColorLight,
              ),
              buttonColor: Colors.blue,
            ),
            select1 == null? Text('') : Text(antifreeze.toString()),
            ButtonTheme(
              minWidth: 150.0,
              height: 30.0,
              child: RaisedButton(
                onPressed: () => selectNextAntifreeze(context),
                child: Text('select next antifreeze date'),
                color: Theme.of(context).primaryColorLight,
              ),
              buttonColor: Colors.blue,),
            select2 == null? Text('') : Text(nextAntifreeze.toString()),
            sampleImage == null ?
            IconButton(
              alignment: Alignment.bottomCenter,
              icon: Icon(Icons.camera_alt,size: 50,),
              onPressed: getImage,
            ) :
            Image.file(sampleImage),
          ],
        ),
      ),
    );
  }
  File sampleImage;
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }
  Car getCar({DateTime antifreeze = null ,int engine_oil = 0,String image_url = '',String mission = '', String name = '',
    DateTime next_antifreeze = null,int next_engine_oil = 0,String next_mission = '',String opinion = ''}) {
    if(antifreeze == null)
      antifreeze =DateTime.now();
    if(next_antifreeze == null)
      next_antifreeze =DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 1 * 1000*2592000);
    return Car(antifreeze,engine_oil,image_url,mission,name,next_antifreeze,next_engine_oil,next_mission,opinion,user.reference.collection('Car').document());
  }
}