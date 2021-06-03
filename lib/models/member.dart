import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/views/my_material.dart';

class Member {

  // Properties
  DocumentReference ref;
  String uid;
  String name;
  String forename;
  String address;
  String implication;
  String imageUrl;
  bool membership;
  bool admin;
  bool superAdmin;
  List<dynamic> clubs;
  List<dynamic> events;
  List<dynamic> blackList;
  List<dynamic> items;
  //String documentId;
  String phone;
  String mail;


  List<String> memberImplicationList = [
    '⚡️ Membre actif',
    '✨ Participant occasionnel',
    '⚜️ Membre d\'honneur',
    '🔍 Visiteur',
  ];

  // Constructor
  Member(DocumentSnapshot snapshot) {
    // documentId = snapshot.id;
    ref = snapshot.reference;
    Map<String, dynamic> map = snapshot.data();
    uid = map[keyUid];
    name = map[keyName];
    forename = map[keyForename];
    address = map[keyAddress];
    implication = map[keyImplication];
    admin = map[keyAdmin];
    membership = map[keyMembership];
    imageUrl = map[keyImageUrl];
    clubs = map[keyClubs];
    events = map[keyEvents];
    phone = map[keyPhone];
    mail = map[keyMail];
    blackList = map[keyBlackList];
    items = map [keyItems];
    superAdmin = map[keySuperAdmin];
  }


  // Methods
  Map<String, dynamic> toMap() {
    return {
      keyRef: ref,
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
      keyItems: items,
      keyPhone: phone,
      keyMail: mail,
      keyBlackList: blackList,
      keySuperAdmin: superAdmin,
    };
  }

  Member.fromMap(Map<String, dynamic> data){
    ref = data[keyRef];
    uid = data[keyUid];
    name = data[keyName];
    forename = data[keyForename];
    address = data[keyAddress];
    implication = data[keyImplication];
    imageUrl = data[keyImageUrl];
    admin = data[keyAdmin];
    membership = data[keyMembership];
    clubs = data[keyClubs];
    events = data[keyEvents];
    items = data[keyItems];
    phone = data[keyPhone];
    mail = data[keyMail];
    blackList = data[keyBlackList];
    superAdmin = data[keySuperAdmin];
  }



}