import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'user.dart';
import 'profile.dart';

String default_url = "https://firebasestorage.googleapis.com/v0/b/final-f741c.appspot.com/o/default_img.png?alt=media&token=aa334b33-ff9b-4c55-9d59-73d2ae82d2f2";

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({this.userInfo});
  User userInfo;

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState(userInfo: userInfo);
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  _ProfileEditPageState({this.userInfo});
  User userInfo;

  Future<File> _imageFile;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _lpController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  @override
  void initState(){
    super.initState();
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
      userInfo.car_url = _imageFile.toString();
    });
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
        title: Text("Profile Editing"),
        centerTitle: true,
        backgroundColor: Colors.black,
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
            child: Image.network(default_url) // car_url이 없으면
        )
            :
          _imageFile == null
            ?
        Container(
            child: Image.network(userInfo.car_url),
          )
              :
        showImage(),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
                icon: Icon(
                    Icons.photo_camera,
                    color: Colors.black
                ),
                onPressed:(){
                  pickImageFromGallery(ImageSource.gallery);
//                  getImage();
                }
            ),
          ],
        ),

        Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _nameController,
                style: TextStyle(
                    color: Colors.blueAccent
                ),
                decoration: InputDecoration(
                    hintText: userInfo.name,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                onChanged: (val){
                  if(val != null)
                    userInfo.name = val;
//                  getName(name);
                },
              ),
            )
        ),

        Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _emailController,
                style: TextStyle(
                    color: Colors.blueAccent
                ),
                decoration: InputDecoration(
                    hintText: userInfo.email,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                onChanged: (val){
                  if(val != null)
                    userInfo.email = val;
                },
              ),
            )
        ),

        Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _phoneController,
                style: TextStyle(
                    color: Colors.blueAccent
                ),
                decoration: InputDecoration(
                    hintText: userInfo.phone,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                onChanged: (val){
                  if(val != null)
                    userInfo.phone = val;
                },
              ),
            )
        ),

        Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _lpController,
                style: TextStyle(
                    color: Colors.blueAccent
                ),
                decoration: InputDecoration(
                    hintText: userInfo.lp,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                onChanged: (val){
                  if(val != null)
                    userInfo.lp = val;
                },
              ),
            )
        ),

        Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _carModelController,
                style: TextStyle(
                    color: Colors.blueAccent
                ),
                decoration: InputDecoration(
                    hintText: userInfo.car_model,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                onChanged: (val){
                  if(val != null)
                    userInfo.car_model = val;
                },
              ),
            )
        ),
        SizedBox(height: 30),

        new RaisedButton(
            child : Text("Save"),
              onPressed: () async{

              print('document name : ' + userInfo.reference.toString());

             /* if(userInfo.name != null)
                userInfo.reference.updateData({'name' : userInfo.name});
              else
                userInfo.reference.updateData({'name' : userInfo.name});
              if(email != null)
                userInfo.reference.updateData({'email' : email});
              else
                userInfo.reference.updateData({'name' : userInfo.email});
              if(phone != null)
                userInfo.reference.updateData({'phone' : phone});
              else
                userInfo.reference.updateData({'name' : userInfo.phone});
              if(lp != null)
                userInfo.reference.updateData({'lp' : lp});
              else
                userInfo.reference.updateData({'name' : userInfo.lp});
              if(car_model != null)
                userInfo.reference.updateData({'car_model' : car_model});
              else
                userInfo.reference.updateData({'name' : userInfo.car_model});
              if(car_url != null)
                userInfo.reference.updateData({'car_url' : _imageFile});
              else
                userInfo.reference.updateData({'name' : userInfo.car_url});*/

             /* await Firestore.instance.runTransaction((Transaction transaction) async{
                  Firestore.instance.collection('userList').document(userInfo.reference.documentID).updateData(
                      {'name' : userInfo.name,
                        'email' : userInfo.email,
                        'phone' : userInfo.phone,
                        'lp' : userInfo.lp,
                        'car_model' : userInfo.car_model,
                        'car_url' : _imageFile == null ? userInfo.car_url : _imageFile,
                      }
                  );
                }
              );*/
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return new ProfilePage(userInfo: userInfo);
                  }));
              }
            )

      ],
    );
  }

}
