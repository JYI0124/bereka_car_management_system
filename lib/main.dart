import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'macket_register.dart';
import 'myusage.dart';
import 'repair.dart';
import 'support.dart';
import 'profile.dart';
import 'signup.dart';
import 'user.dart';
import 'manager.dart';

void main() => runApp(MyApp());

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
bool _log_stat = false;
String uid;
FirebaseUser user;
String default_url = "https://firebasestorage.googleapis.com/v0/b/final-f741c.appspot.com/o/default_img.png?alt=media&token=aa334b33-ff9b-4c55-9d59-73d2ae82d2f2";


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bereka',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {

  final drawerItems = [
    DrawerItem("내 페이지", Icons.home),
    DrawerItem("수리견적", Icons.sync),
    DrawerItem("이용내역", Icons.search),
    DrawerItem("고객 지원 센터", Icons.location_city),
    DrawerItem("입점 문의", Icons.insert_chart),
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  var drawerOptions = <Widget>[];
  final TextEditingController _searchController = new TextEditingController();
  String search_val;

  PageController _pageController;
  int currentPage = 1;
  bool _success = false;
  String _userID;
//  bool _log_stat = false;
  File _imageFile;
  User corr_user;
  List<User> users;
  User cUser;


  @override
  void initState(){
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      Navigator.of(context).pop(); // close the drawer

      if(index == 0) {

      } else if(index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RepairPage()),
        );
      } else if(index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyUsagePage()),
        );
      } else if(index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupportPage()),
        );
      } else if(index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MackgetRegisterPage()),
        );
      }
      _selectedDrawerIndex = 0;
    });
  }


/*  _showLogInSnackBar(){
    if(_log_stat == true){
      print('logged in');
      final snackBar = new SnackBar(
        content: new Text("Successfully logged in"),
      );
      _scaffoldkey.currentState.showSnackBar(snackBar);
    }
  }*/



  @override
  Widget build(BuildContext context) {


    drawerOptions = <Widget>[];
    for (var i = 1; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          ListTile(
            leading: Icon(d.icon),
            title: Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bereka",
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () async {
             if(_log_stat == true){
               print("alarm pressed");
               _signOut();
              setState((){
                _log_stat = false;
                _success = false;
              });
//               _showLogOutSnackBar();
             }


            },
          ),
          IconButton(
            icon: Icon(
                _success == false
                    ?
                Icons.lock
                    :
                Icons.lock_open
            ),
            onPressed: () async {

              print(_success);
              if(_success == false){
                print("lock pressed");

                _showLoginDialog();
                setState(() {
                  _log_stat = true;
                  _success = true;


                });
                user = await _auth.currentUser();
                print('logged uid : ' + user.uid);

                /*Future<QuerySnapshot> snapshot= Firestore.instance.collection('userList').getDocuments();
                users = new List<User>();
                snapshot.then((val) {
                  List<DocumentSnapshot> documents = val.documents;
                  for (DocumentSnapshot sh in documents) {
                    User snap_user = User.fromSnapshot(sh);
                    if(snap_user.email == user.email) {
                      cUser = snap_user;
                    }
                    users.add(snap_user);
                  }
                  List<User> clients = new List<User>();
                  for(User u in users) {
                    if(cUser.clients.contains(u.email)) {
                      clients.add(u);
                    }
                  }
                  if(cUser.manager) {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ManagerPage(users,cUser,clients)),);
                  }
                });*/



//                _showLogInSnackBar();
              }
            },
          ),
        ],
      ),
      drawer: get_drawer(),
      body: Column(
//        child: Text('data'),
        children: <Widget>[

          SizedBox(height: 40),
          Row(
            children: <Widget>[
              Flexible(
                child:  Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextField(
//                textAlign: TextAlign.center,
//                     autofocus: true,
//                     obscureText: true,
                        controller: _searchController,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        decoration: InputDecoration(
                          hintText: "Search..",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (val){
                          search_val = val;
                        }
                    ),
                  ),
                ),
              ),

              IconButton(
                  icon: Icon(Icons.search),

                  onPressed: () {
                    print('searching...');
                  }
              ),
            ],
          ),
          /*Expanded(
              child: Container(
                child: new CarouselSlider(
                    items: [1,2,3,4,5].map((i) {

                      if(i == 1){
                        return new Builder(
                          builder: (BuildContext context){
                            return new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: new EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: new BoxDecoration(
                                color: Colors.grey,

                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 50,
                                ),
                                onPressed: () async{
//                                  print('pressed');


                                },
                              ),
//                             child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
                            );
                          },
                        );
                      }
                      return new Builder(
                        builder: (BuildContext context) {
                          return new Container(
                            width: MediaQuery.of(context).size.width,
                            margin: new EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: new BoxDecoration(
                              color: Colors.grey,
                              gradient: new LinearGradient(
                                colors: [Colors.black, Colors.grey],
                              ),
                            ),
//                             child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                    height: 400.0,
                    autoPlay: false
                ),
//                   Text(product.name),
              ),
          )*/
        ],
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
    print('_signOut method logged out');

    setState(() {
      _log_stat = false;
      _success = false;
    });
  }

  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
      } else {
        _success = false;
      }

      if(_success){
        Navigator.pushNamed(context, '/home');
      }
    });
  }


  void _showLoginDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Container(
              height: 100,
              width: double.infinity,

              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height:50,
                    width: double.infinity,
                    child: _GoogleSignInSection()
                  )
              ),
            ),
          );
        }
    );

  }

  animateItemBuilder(int index){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 250,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: index % 2 == 0 ? Colors.grey : Colors.black,
      ),
    );
  }

  Drawer get_drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.cyan,
              child: new Image.network(
                  user == null ? "" : user.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
              accountName: Text("Pages", style: TextStyle(fontSize: 20),), accountEmail: Text(user == null ? "" : user.email.toString()),
            onDetailsPressed: () async {
              print('profile setting');

              Future<QuerySnapshot> snapshot= Firestore.instance.collection('userList').getDocuments();
              snapshot.then((val) {
//                List<User> _users = List<User>();

                List<DocumentSnapshot> documents = val.documents;
                for(DocumentSnapshot sh in documents) {
                  User _user = User.fromSnapshot(sh);
                  print(_user.name);
                  if(user.uid == _user.uid){
                      corr_user = _user;
                  }
                }
                print(corr_user.name);
                if(corr_user.name == null){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupPage()),);
                }

                else{
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage(userInfo: corr_user, name: corr_user.name, email: corr_user.email, phone: corr_user.phone, car_model: corr_user.car_model, lp: corr_user.lp, car_url: corr_user.car_url)));
                }

              });
            },

          ),

          Column(children: drawerOptions)
        ],
      ),
    );
  }
}

class _GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool _success;
  String _userID;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: 50,
//            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                _signInWithGoogle();
              },
              child:Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assignment_ind),
                    Center(
                      child: Text('Sign in Google', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),

              color: Colors.redAccent,
            ),
          ),
          /*Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in, uid: ' + _userID
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          )*/
        ],
      );

  }

  // Example code of how to sign in with google.
  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
      } else {
        _success = false;
      }

      if(_success){
      Navigator.pop(context);
      }
    });
  }
}