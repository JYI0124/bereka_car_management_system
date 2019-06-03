import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'user.dart';
import 'profileEdit.dart';

String default_url = "https://firebasestorage.googleapis.com/v0/b/final-f741c.appspot.com/o/default_img.png?alt=media&token=aa334b33-ff9b-4c55-9d59-73d2ae82d2f2";

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userInfo, this.name, this.email, this.phone, this.car_model, this.lp, this.car_url});

  User userInfo;
  String name;
  String email;
  String phone;
  String car_model;
  String lp;
  String car_url;
  @override
  _ProfilePageState createState() => _ProfilePageState(userInfo: userInfo, name: name, email: email, phone: phone, car_model: car_model, lp: lp, car_url: car_url);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState({this.userInfo, this.name, this.email, this.phone, this.car_model, this.lp, this.car_url});

  User userInfo;
  String name;
  String email;
  String phone;
  String car_model;
  String lp;
  String car_url;

//  File _imageFile;
  Future<File> _imageFile;

  @override
  void initState(){
    super.initState();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setting"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return new ProfileEditPage(userInfo: userInfo);
                  }));
            },
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),

              child: new Form(
                child: FormUI(),
              ),
            )),
      ),
    );
  }

  Widget FormUI(){
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _imageFile == null
            ?
        Container(
            child: Image.network(default_url)
        )
            :
        showImage(),

        new Text("Name : " + name, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text("Email : " + email, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text("Phone \# : " + phone, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text("Car Model : " + car_model, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text("License Plate \#" + lp, style: TextStyle(fontSize: 20),),

      ],
    );
  }

}
