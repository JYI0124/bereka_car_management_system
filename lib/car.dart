import 'package:cloud_firestore/cloud_firestore.dart';
class Car {
  final String name;
  final int engine_oil;
  final String image_url;
  final String mission;
  final int next_engine_oil;
  final DocumentReference reference;
  final String next_mission;
  final DateTime antifreeze;
  final String opinion;
  final DateTime next_antifreeze;

  Car(
      this.antifreeze,
      this.engine_oil,
      this.image_url,
      this.mission,
      this.name,
      this.next_antifreeze,
      this.next_engine_oil,
      this.next_mission,
      this.opinion,
      this.reference,
      );

  Car.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['engine_oil'] != null),
        assert(map['image_url'] != null),
        assert(map['mission'] != null),
        assert(map['next_engine_oil'] != null),
        assert(map['next_mission'] != null),
        assert(map['antifreeze'] != null),
        assert(map['next_antifreeze'] != null),
        assert(map['opinion'] != null),
        name = map['name'],
        engine_oil = map['engine_oil'],
        image_url = map['image_url'],
        mission = map['mission'],
        next_engine_oil = map['next_engine_oil'],
        next_antifreeze = DateTime.fromMillisecondsSinceEpoch(map['next_antifreeze'].millisecondsSinceEpoch),
        next_mission = map['next_mission'],
        opinion = map['opinion'],
        antifreeze = DateTime.fromMillisecondsSinceEpoch(map['antifreeze'].millisecondsSinceEpoch);

  Car.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}