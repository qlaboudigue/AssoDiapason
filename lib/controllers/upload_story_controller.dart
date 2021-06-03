import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UploadStoryController extends StatefulWidget {

  @override
  _UploadStoryControllerState createState() => _UploadStoryControllerState();
}

class _UploadStoryControllerState extends State<UploadStoryController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Story _currentStory;

  TextEditingController _dateController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    // Load in local variable _currentStory the Notifier's Current Story or an empty instance
    StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Load current user into current activity leader
    if(storyNotifier.currentStory != null && memberNotifier.currentMember != null) {
      // UPDATE CASE
      _currentStory = storyNotifier.currentStory;
      _selectedDate = DateTime.fromMillisecondsSinceEpoch(_currentStory.endtime);
      _dateController.text = DateFormat.yMMMMd('fr_FR').format(_selectedDate);
    } else {
      // NEW STORY CASE
      _currentStory = Story();
      _currentStory.field = _currentStory.fieldsList[0];
      _currentStory.writer = memberNotifier.currentMember.uid;
    }
    // _backgroundImageUrl = _currentStory.backgroundImageUrl; // Null in case of a creation, URL String in case of an update
  }


  Widget _showFields(Color color) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: (){
              setState(() {
                _currentStory.field = _currentStory.fieldsList[0];
              });
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  kFieldOneIconData,
                  size: 30.0,
                  color: (_currentStory.field == _currentStory.fieldsList[0]) ? kOrangeMainColor : kWhiteColor,
                )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentStory.field = _currentStory.fieldsList[1];
              });
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                    kFieldTwoIconData,
                    size: 30.0,
                    color: (_currentStory.field == _currentStory.fieldsList[1]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentStory.field = _currentStory.fieldsList[2];
              });
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                    kFieldThreeIconData,
                    size: 30.0,
                    color: (_currentStory.field == _currentStory.fieldsList[2]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentStory.field = _currentStory.fieldsList[3];
              });
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                    kFieldFourIconData,
                    size: 30.0,
                    color: (_currentStory.field == _currentStory.fieldsList[3]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateTitle(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentStory.title = value.capitalize();
      return null;
    }
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentStory.description = value;
      return null;
    }
  }

  String _validateSpot(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentStory.spot = value.capitalize();
      return null;
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      locale: Locale("fr"),
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 2),
      lastDate: DateTime(_selectedDate.year + 2),
      helpText: 'Sélectionner une date',
      cancelText: 'Annuler',
      confirmText: 'Valider',
      errorFormatText: 'Entrer une date valide',
      errorInvalidText: 'Entrer une date dans l\'intervalle autorisé',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  String _validateDate(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentStory.endtime = DateHelper().fromDateTimeToInt(_selectedDate);
      return null;
    }
  }

  _saveStory(Story story) {
    if(_formKey.currentState.validate()){
      StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
      DiapasonApi().uploadStory(storyNotifier, story);
      Navigator.pop(context);
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _dateController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: (_currentStory.sid != null)
            ? UpdateAppBarText('Modifier la story')
            : UpdateAppBarText('Ajouter une story'),
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
            color: kWhiteColor, //change your color here
          ),
          backgroundColor: kBarBackgroundColor,
          elevation: 0.0,
          actions: <Widget>[
            AppBarDecorationIcon(icon: FontAwesomeIcons.book)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _showFields(kDrawerDividerColor),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0,),
                      child: RegulationRegularText(
                        _currentStory.field,
                        fontSize: 18.0,
                        color: kOrangeMainColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0,),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: kWhiteColor),
                        child: TextFormField(
                          style: TextStyle(color: kWhiteColor),
                          initialValue: _currentStory.title,
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
                            labelText: 'Activité',
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
                              Icons.title,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateTitle,
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
                          initialValue: _currentStory.description,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 150,
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
                            labelText: 'Objectif pédagogique',
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
                              Icons.description,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateDescription,
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
                          initialValue: _currentStory.spot,
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
                            labelText: 'Spot',
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
                              Icons.location_on_outlined,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateSpot,
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
                          controller: _dateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTap: () async {
                            await _selectDate(context);
                            setState(() {
                              _dateController.text =
                              '${DateFormat.yMMMMd('fr_FR').format(_selectedDate)}';
                            });
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
                            labelText: 'Date',
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
                              Icons.event,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateDate
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
                            _saveStory(_currentStory);
                          }
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}


