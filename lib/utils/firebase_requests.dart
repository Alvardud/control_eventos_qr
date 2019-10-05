import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_eventos_qr/models/company.dart';

final databaseReference = Firestore.instance;

Future<List<Company>> getCompanies(String type) async {
  List<Company> _companies = [];
  QuerySnapshot _t = await databaseReference.collection(type).getDocuments();
  for (int i = 0; i < _t.documents.length; i++) {
    _companies.add(Company.fromSnapshot(_t.documents[i]));
  }
  return _companies;
}