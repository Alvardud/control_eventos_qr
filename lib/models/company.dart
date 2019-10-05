import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String name;
  String type;
  String linkLogo;
  String pass;

  Company({
    this.linkLogo,
    this.name,
    this.type,
    this.pass,
  });

  factory Company.fromSnapshot(DocumentSnapshot snapshot) {
    return Company(
        linkLogo: null,
        name: snapshot.data['name'],
        type: snapshot.data['type'],
        pass: snapshot.data['pass']);
  }
}
