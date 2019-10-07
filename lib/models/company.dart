import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String name;
  String type;
  String linkLogo;
  String pass;
  String desc;

  Company({
    this.linkLogo,
    this.name,
    this.type,
    this.pass,
    this.desc,
  });

  String get getName => this.name;
  String get getType => this.name;
  String get getLinkLogo => this.name;

  set setName(String n) => this.name = n;
  set setType(String t) => this.type = t;
  set setLinkImage(String li) => this.linkLogo = li;

  factory Company.fromSnapshot(DocumentSnapshot snapshot) {
    return Company(
        linkLogo: null,
        name: snapshot.data['name'],
        type: snapshot.data['type'],
        desc: snapshot.data['desc'],
        pass: snapshot.data['pass']);
  }
}
