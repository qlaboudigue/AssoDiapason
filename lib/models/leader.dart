import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/views/my_material.dart';

class Leader extends Member {

  // Properties
  int valuation;

  List<String> expertiseList = [
    'Pur débutant.e',
    'Pratiquant.e régulier.e',
    'Référent.e potentiel.le',
    'Guide Diapason',
    'Administrateur.trice',
  ];

  // Constructor
  Leader(DocumentSnapshot snapshot) : super (snapshot) {
    Map<String, dynamic> map = snapshot.data();
    valuation = map[keyValuation];
  }

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keyUid: uid,
      keyName: name,
      keyForename: forename,
      keyAddress: address,
      keyImplication: implication,
      keyImageUrl: imageUrl,
      keyAdmin: admin,
      keyMembership: membership,
      keyClubs: clubs,
      keyEvents: events,
      keyPhone: phone,
      keyMail: mail,
      keyValuation: valuation,
    };
  }

  Leader.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    valuation = data[keyValuation];
  }

  String getValuation() {
    String _valuation;
    switch(valuation) {
      case 0: {
        _valuation = expertiseList[0];
        return _valuation;
      } break;
      case 1: {
        _valuation = expertiseList[1];
        return _valuation;
      } break;
      case 2: {
        _valuation = expertiseList[2];
        return _valuation;
      } break;
      case 3: {
        _valuation = expertiseList[3];
        return _valuation;
      } break;
      case 4: {
        _valuation = expertiseList[4];
        return _valuation;
      } break;
      default: {
        _valuation = expertiseList[2];
        return _valuation;
      }
    }
  }

}