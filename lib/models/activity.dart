import 'package:diapason/views/my_material.dart';

class Activity {

  // Properties
  String aid;
  String name;
  String leader;
  String category;
  String iconImageUrl;
  String backgroundImageUrl;
  // List<dynamic> experts = [];
  List<String> activityCategoriesList = [
    'Sport',
    'Art',
    'Artisanat',
    'Animation',
    'Media',
  ];

  // Constructor
  Activity();

  // Methods
  Activity.fromMap(Map<String, dynamic> data) {
    aid = data[keyAid];
    name = data[keyName];
    leader = data[keyLeader];
    category = data[keyCategory];
    iconImageUrl = data[keyIconImageUrl];
    backgroundImageUrl = data[keyBackgroundImageUrl];
    // experts = data[keyExperts];
  }

  Map<String, dynamic> toMap() {
    return {
      keyAid: aid,
      keyName: name,
      keyLeader: leader,
      keyCategory: category,
      keyIconImageUrl: iconImageUrl,
      keyBackgroundImageUrl: backgroundImageUrl,
      // keyExperts: experts,
    };
  }


}