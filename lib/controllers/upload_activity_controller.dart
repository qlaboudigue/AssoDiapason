import 'dart:io';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/activity.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadActivityController extends StatefulWidget {

  @override
  _UploadActivityControllerState createState() => _UploadActivityControllerState();
}

class _UploadActivityControllerState extends State<UploadActivityController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Activity _currentActivity;
  Member _currentMember;

  // Properties managing background image
  String _backgroundImageUrl;
  File _backgroundImageSelected;
  final pickerBack = ImagePicker();

  // Properties managing background image
  String _iconImageUrl;
  File _iconImageSelected;
  final pickerIcon = ImagePicker();


  @override
  void initState() {
    super.initState();
    // Load in local variable _currentActivity the Notifier's Current Activity or an empty instance
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Load current user into current activity leader
    if(activityNotifier.currentActivity != null && memberNotifier.currentMember != null) {
      _currentActivity = activityNotifier.currentActivity; // Case : Comes from "Update Activity Button"
      // print('Current activity loaded for update in controller');
    } else {
      _currentActivity = Activity(); // Case : Comes from "Create new event button"
      _currentActivity.leader = memberNotifier.currentMember.uid;
      // print('Empty current activity in controller');
    }
    _iconImageUrl = _currentActivity.iconImageUrl;
    _backgroundImageUrl = _currentActivity.backgroundImageUrl; // Null in case of a creation, URL in case of update
    _currentMember = memberNotifier.currentMember;
  }

  Widget _showBackImage() {
    if(_backgroundImageUrl == null && _backgroundImageSelected == null){
      return Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width * 9) / 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: kActivityDefaultImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(
            Icons.camera_enhance_rounded,
            size: 40.0,
            color: kOrangeMainColor,
          )
      );
    } else if (_backgroundImageSelected != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width * 9) / 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.file(_backgroundImageSelected).image),
        ),
      );
    } else if (_backgroundImageUrl != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width * 9) / 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (_backgroundImageUrl != '') ? Image.network(_backgroundImageUrl).image : kActivityDefaultImage
          ),
        ),
      );
    } else {
      return EmptyContainer();
    }
  }

  Widget _showIconImage() {
    if(_iconImageUrl == null && _iconImageSelected == null){
      return Container(
          width: 130.0,
          height: 130.0,
          decoration: BoxDecoration(
            color: kDrawerDividerColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_enhance_rounded,
                size: 40.0,
                color: kOrangeMainColor,
              ),
              SizedBox(height: 5.0),
              NumberText('Icône'),
            ],
          )
      );
    } else if (_iconImageSelected != null) {
      return Container(
        width: 130.0,
        height: 130.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.file(_iconImageSelected).image),
        ),
      );
    } else if (_iconImageUrl != null) {
      return Container(
        width: 130.0,
        height: 130.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (_iconImageUrl != '') ? Image.network(_iconImageUrl).image : kActivityDefaultImage
          ),
        ),
      );
    } else {
      return EmptyContainer();
    }
  }


  Future<void> _selectBackPicture(ImageSource source) async {
    final pickedFile = await pickerBack.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _backgroundImageSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _selectIconPicture(ImageSource source) async {
    final pickedFile = await pickerBack.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _iconImageSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentActivity.name = value.capitalize();
      return null;
    }
  }

  String _validateCategory(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentActivity.category = value.capitalize();
      return null;
    }
  }

  _saveActivity(Activity activity) {
    if(_formKey.currentState.validate()){
      ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
      DiapasonApi().uploadActivity(activityNotifier, activity, _backgroundImageSelected, _iconImageSelected, _currentMember);
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
          title: (_currentActivity.aid != null)
              ? UpdateAppBarText('Modifier l\'activité')
              : UpdateAppBarText('Ajouter une activité'),
          leading: IconButton(
              icon: Icon(
                Icons.cancel,
                size: 30.0,
                color: kOrangeMainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          iconTheme: IconThemeData(
            color: kOrangeMainColor, //change your color here
          ),
          backgroundColor: kBarBackgroundColor,
          elevation: 0.0,
          centerTitle: true, // android override
          actions: <Widget>[
            AppBarDecorationIcon(icon: FontAwesomeIcons.centos)
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      AlertHelper().showPictureOptions(
                        context,
                        () => _selectBackPicture(ImageSource.camera),
                        () => _selectBackPicture(ImageSource.gallery),
                      );
                    },
                    child: _showBackImage(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            AlertHelper().showPictureOptions(
                              context,
                                  () => _selectIconPicture(ImageSource.camera),
                                  () => _selectIconPicture(ImageSource.gallery),
                            );
                          },
                          child: Container(
                            // padding: EdgeInsets.only(top: 15.0),
                              child: _showIconImage()
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 15.0,),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: kWhiteColor,
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(color: kWhiteColor),
                                    initialValue: _currentActivity.name,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    maxLength: 25,
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
                                      labelText: 'Activité',
                                      prefixIcon: Icon(
                                        Icons.title,
                                        color: kOrangeMainColor,
                                      ),
                                    ),
                                    validator: _validateName,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15.0,),
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(primaryColor: kWhiteColor),
                                  child: TextFormField(
                                    style: TextStyle(color: kWhiteColor),
                                    initialValue: _currentActivity.category,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    maxLength: 20,
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
                                      labelText: 'Catégorie',
                                      prefixIcon: Icon(
                                        Icons.category,
                                        color: kOrangeMainColor,
                                      ),
                                    ),
                                    validator: _validateCategory,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: GenericButton(
                        label: 'Valider',
                        buttonColor: kOrangeAccentColor,
                        onTap: () {
                          _saveActivity(_currentActivity);
                        }
                    ),
                  ),
                ],
              )),
        ));
  }
}
