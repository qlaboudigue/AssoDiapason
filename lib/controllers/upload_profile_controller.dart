import 'dart:io';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/address_search.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/util/place_service.dart';
import 'package:diapason/views/pages/data_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadProfileController extends StatefulWidget {
  @override
  _UploadProfileControllerState createState() =>
      _UploadProfileControllerState();
}

class _UploadProfileControllerState extends State<UploadProfileController> {

  // STATE PROPERTIES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Member _currentMember;

  String _imageUrl;
  File _imageSelected;
  final picker = ImagePicker();

  TextEditingController _addressController;

  // INITIALISATION & DISPOSE
  @override
  void initState() {
    super.initState();
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    if (memberNotifier.currentMember != null) {
      _currentMember = memberNotifier.currentMember;
    }
    _imageUrl = _currentMember.imageUrl;
    _addressController = TextEditingController();
    _addressController.text = _currentMember.address;
  }

  @override
  void dispose() {
    _addressController?.dispose();
    super.dispose();
  }

  // FUNCTIONS
  Widget _showImage() {
    if (_imageUrl == null && _imageSelected == null) {
      return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Center(
            child: CircleAvatar(
              radius: 43.0,
              backgroundColor: kOrangeAccentColor,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: kProfileDefaultImage,
              ),
            )
        ),
      );
    } else if (_imageSelected != null) {
      return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Center(
            child: CircleAvatar(
              radius: 43.0,
              backgroundColor: kOrangeAccentColor,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: Image.file(_imageSelected).image,
          ),
        )),
      );
    } else if (_imageUrl != null) {
      return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Center(
          child: ProfileImage(
            urlString: _currentMember.imageUrl,
            size: 40.0,
            color: kOrangeAccentColor,
            onTap: () {
              AlertHelper().showPictureOptions(
                context,
                    () => _selectPicture(ImageSource.camera, context),
                    () => _selectPicture(ImageSource.gallery, context),
              );
            },
          ),
        ),
      );
    } else {
      return null;
    }
  }

  Widget _showImplication(){
    if(_currentMember.membership == true) {
      return Container(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kDrawerDividerColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Builder(
            builder: (context) => DropdownButton(
              icon: Icon(
                Icons.arrow_circle_down_rounded,
                color: kOrangeMainColor,
              ),
              iconSize: 30.0,
              elevation: 30,
              underline: Container(
                width: 0.0,
                height: 0.0,
              ),
              isExpanded: true,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: kWhiteColor,
                ),
              ),
              dropdownColor: kUpdateDropBackgroundColor,
              // isDense: true,
              value: _currentMember.implication,
              onChanged: (newValue) {
                setState(() {
                  _currentMember.implication = newValue;
                });
              },
              items: _currentMember.memberImplicationList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  Future<void> _selectPicture(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  String _validateForename(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentMember.forename = value.capitalize();
      return null;
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentMember.name = value.capitalize();
      return null;
    }
  }

  String _validatePhone(String value) {
    Pattern pattern = r'^(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Champ requis';
    } else if (!regex.hasMatch(value)) {
      return 'Numéro invalide';
    } else
      _currentMember.phone = value;
    return null;
  }

  String _validateAddress(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentMember.address = value;
      return null;
    }
  }

  _saveProfile(Member member) {
    if(_formKey.currentState.validate()){
      MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
      DiapasonApi().uploadMember(memberNotifier, _currentMember, _imageSelected);
      Navigator.pop(context);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: UpdateAppBarText('Modifier mon profil'),
        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        leading: IconButton(
            icon: Icon(
              Icons.cancel,
              size: 30.0,
              color: kOrangeMainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: kBarBackgroundColor,
        elevation: 0.0,
        centerTitle: true, // android override
        actions: <Widget>[
          AppBarDecorationIcon(icon: FontAwesomeIcons.idCard)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      AlertHelper().showPictureOptions(
                        context,
                        () => _selectPicture(ImageSource.camera, context),
                        () => _selectPicture(ImageSource.gallery, context),
                      );
                    },
                    child: _showImage(),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
                    child: SharedSubTextWidget(
                      'Mon implication',
                      fontSize: 18.0,
                    ),
                  ),
                  _showImplication(),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                        style: TextStyle(color: kWhiteColor),
                        initialValue: _currentMember.forename,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 15,
                        decoration: InputDecoration(
                          hintStyle:
                          TextStyle(color: kWhiteColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          labelText: 'Prénom',
                          errorStyle:
                          TextStyle(color: kWhiteColor),
                          counterStyle:
                          TextStyle(color: kWhiteColor),
                          labelStyle: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: kWhiteColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.info,
                            color: kOrangeMainColor,
                          ),
                        ),
                        validator: _validateForename,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                        style: TextStyle(color: kWhiteColor),
                        initialValue: _currentMember.name,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 15,
                        decoration: InputDecoration(
                          hintStyle:
                          TextStyle(color: kWhiteColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          labelText: 'Nom',
                          errorStyle:
                          TextStyle(color: kWhiteColor),
                          counterStyle:
                          TextStyle(color: kWhiteColor),
                          labelStyle: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: kWhiteColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.info,
                            color: kOrangeMainColor,
                          ),
                        ),
                        validator: _validateName,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                        style: TextStyle(color: kWhiteColor),
                        initialValue: _currentMember.phone,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintStyle:
                          TextStyle(color: kWhiteColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kWhiteColor),
                          ),
                          labelText: 'Numéro de téléphone',
                          errorStyle:
                          TextStyle(color: kWhiteColor),
                          counterStyle:
                          TextStyle(color: kWhiteColor),
                          labelStyle: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: kWhiteColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: kOrangeMainColor,
                          ),
                        ),
                        validator: _validatePhone,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 21.0, bottom: 15.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                          style: TextStyle(color: kWhiteColor),
                          controller: _addressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTap: () async {
                            // generate a new token here
                            final sessionToken = Uuid().v4();
                            final Suggestion result = await showSearch(
                              context: context,
                              delegate: AddressSearch(sessionToken),
                            );
                            if (result != null) {
                              setState(() {
                                _addressController.text = result.description;
                              });
                            }
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintStyle:
                            TextStyle(color: kWhiteColor),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: kWhiteColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: kWhiteColor),
                            ),
                            labelText: 'Adresse',
                            errorStyle:
                            TextStyle(color: kWhiteColor),
                            counterStyle:
                            TextStyle(color: kWhiteColor),
                            labelStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.home,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateAddress),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                    child: SharedRegularTextWidget(
                      'Pour toute question concernant vos données personnelles, veuillez consulter notre : ',
                      color: kWhiteColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PrivacyPolicyPage.route);
                      },
                      child: Center(
                        child: HomeUnderlinedText(
                          'Politique de confidentialité',
                          color: kOrangeMainColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: GenericButton(
                        label: 'Valider',
                        buttonColor: kOrangeAccentColor,
                        onTap: () {
                          _saveProfile(_currentMember);
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
