import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/views/my_material.dart';

class Claim {

  // Properties
  DocumentReference ref;
  String cid;
  String content;
  String type;
  bool isHate;
  bool isSexual;
  bool isDelusive;
  bool isCopyrighted;
  String description;
  int severity;
  int date;
  String status;
  // bool hasBeenHandled;

  List<String> claimTypeList = [
    '👤 Utilisateur',
    '📆️ Événement',
    '💭 Story',
    '✴️ Activité',
    '🛠 Objet',
  ];

  List<String> claimStatusList = [
    '🟡  En attente de traitement',
    '🟢  Demande traitée : Contenu supprimé',
    '🔵  Demande traitée : Contenu conservé',
  ];
  
  // Constructor
  Claim();

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keyCid: cid,
      keyContent: content,
      keyType: type,
      keyIsHate: isHate,
      keyIsSexual: isSexual,
      keyIsDelusive: isDelusive,
      keyIsCopyrighted: isCopyrighted,
      keyDescription: description,
      keySeverity: severity,
      keyDate: date,
      keyStatus: status,
    };
  }

  Claim.fromMap(Map<String, dynamic> data){
    cid = data[keyCid];
    content = data[keyContent];
    type = data[keyType];
    isHate = data[keyIsHate];
    isSexual = data[keyIsSexual];
    isDelusive = data[keyIsDelusive];
    isCopyrighted = data[keyIsCopyrighted];
    description = data[keyDescription];
    severity = data[keySeverity];
    date = data[keyDate];
    status = data[keyStatus];
  }
}