import 'package:diapason/views/my_material.dart';

class Item {

  // Properties
  String iId; // Declare instance variable iId
  String name;
  String description;
  String iconImageUrl;
  String imageOneUrl;
  String imageTwoUrl;
  String imageThreeUrl;
  // List<dynamic> activitiesList;
  String loanTerm;
  String owner;
  String borrower;
  int price;
  String state;

  List<String> itemState = [
    '🟢  Neuf',
    '🟡  Bon état',
    '🟠  Usagé',
  ];

  List<String> loanStatues = [
    '🟢  Actuellement disponible',
    '🛑  Actuellement prêté',
  ];

  List<String> loanTerms = [
    '🟢  En libre service',
    '🟡  Être formé.e avant utilisation',
    '🟠  Usage encadré',
  ];

  // Constructor
  Item();

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keyIid: iId,
      keyName: name,
      keyDescription: description,
      keyImageOneUrl: imageOneUrl,
      keyImageTwoUrl: imageTwoUrl,
      keyImageThreeUrl: imageThreeUrl,
      keyIconImageUrl: iconImageUrl,
      //keyActivitiesList: activitiesList,
      keyLoanTerm: loanTerm,
      keyOwner: owner,
      keyBorrower: borrower,
      keyPrice: price,
      keyState: state,
    };
  }

  Item.fromMap(Map<String, dynamic> data){
    iId = data[keyIid];
    name = data[keyName];
    description = data[keyDescription];
    imageOneUrl = data[keyImageOneUrl];
    imageTwoUrl = data[keyImageTwoUrl];
    imageThreeUrl = data[keyImageThreeUrl];
    iconImageUrl = data[keyIconImageUrl];
    // activitiesList = data[keyActivitiesList];
    loanTerm = data[keyLoanTerm];
    owner = data[keyOwner];
    borrower = data[keyBorrower];
    price = data[keyPrice];
    state = data[keyState];
  }

  // For displaying images in carousel
  List<String> itemImageList() {
    List<String> _imagesUrl = [];
    if (imageOneUrl != null && imageOneUrl != '') {
      _imagesUrl.add(imageOneUrl);
    }
    if (imageTwoUrl != null && imageTwoUrl != '') {
      _imagesUrl.add(imageTwoUrl);
    }
    if (imageThreeUrl != null && imageThreeUrl != '') {
      _imagesUrl.add(imageThreeUrl);
    }
    return _imagesUrl;
  }




}