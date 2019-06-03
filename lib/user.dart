import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  final String name;
  final String car_model;
  String car_url;
  final String email;

  final String lp;
  final String password;
  final String uid;
  final String phone;
  List<String> clients;

  final DocumentReference reference;
  bool manager;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['car_model'] != null),
        assert(map['email'] != null),
        assert(map['lp'] != null),
        assert(map['password'] != null),
        assert(map['uid'] != null),
        assert(map['phone'] != null),
        assert(map['manager'] != null),
        name = map['name'],
        car_model = map['car_model'],
        car_url = map['car_url'],
        email = map['email'],
        lp = map['lp'],
        uid = map['uid'],
        phone = map['phone'],
        password = map['password'],
        clients = List.from(map['clients']),
        manager = map['manager'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}