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
  ProfilePage({this.userInfo});

  User userInfo;

  @override
  _ProfilePageState createState() => _ProfilePageState(userInfo: userInfo);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState({this.userInfo});

  User userInfo;

  @override
  void initState(){
    super.initState();
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
        userInfo.car_url == null
            ?
        Container(
            child: Image.network(default_url)
        )
            :
        Container(
            child: Image.network(userInfo.car_url),
        ),

        new Text(userInfo.name == null ? "" : "Name : " +  userInfo.name, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text(userInfo.email == null ? "" : "Email : " +  userInfo.email, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text(userInfo.phone == null ? "" : "Phone \# : " +  userInfo.phone, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text(userInfo.car_model == null ? "" : "Car Model : " +  userInfo.car_model, style: TextStyle(fontSize: 20),),

        new SizedBox(height: 12.0),

        new Text(userInfo.lp == null ? "" : "License Plate \#" + userInfo.lp, style: TextStyle(fontSize: 20),),

      ],
    );
  }

}
