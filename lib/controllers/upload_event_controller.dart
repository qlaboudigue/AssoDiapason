import 'dart:io';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/event.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/address_search.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/util/date_helper.dart';
import 'package:diapason/util/place_service.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadEventController extends StatefulWidget {

  @override
  _UploadEventControllerState createState() => _UploadEventControllerState();
}

class _UploadEventControllerState extends State<UploadEventController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Event _currentEvent;

  // Background image properties
  String _imageUrl;
  File _imageSelected;
  final pickerBack = ImagePicker();

  // Address property
  TextEditingController _addressController;

  // Date properties
  TextEditingController _dateController;
  DateTime _selectedDate = DateTime.now();
  DateTime _eventDate;

  // Starting time properties
  TextEditingController _timeController;
  TimeOfDay _actualTime = TimeOfDay(hour: 18, minute: 00); // Starting time picker parameter
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Capacity property
  double _capacity = 2.0;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    // Load in local variable _currentStory the Notifier's Current Story or an empty instance
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Load current user into current activity leader
    if(eventNotifier.currentEvent != null && memberNotifier.currentMember != null) {
      // UPDATE CASE
      _currentEvent = eventNotifier.currentEvent;
      _addressController.text = _currentEvent.address;
      _selectedDate = DateTime.fromMillisecondsSinceEpoch(_currentEvent.date);
      _dateController.text = DateFormat.yMMMMd('fr_FR').format(_selectedDate);
      _selectedTime = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(_currentEvent.date));
      _timeController.text = DateHelper().timeFromDate(_currentEvent.date);
      _capacity = _currentEvent.capacity.toDouble();
    } else {
      // NEW STORY CASE
      _currentEvent = Event();
      _currentEvent.field = _currentEvent.fieldsList[0]; // Tour d'horizon by default
      _currentEvent.capacity = 2;
      _currentEvent.price = 0;
      _currentEvent.referent = memberNotifier.currentMember.uid;
    }
    _imageUrl = _currentEvent.imageUrl; // Null in case of a creation, URL String in case of an update
  }

  Widget _showImage() {
    if(_imageUrl == null && _imageSelected == null){
      return Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width * 9) / 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: kEventDefaultImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(
            Icons.camera_enhance_rounded,
            size: 40.0,
            color: kOrangeMainColor,
          )
      );
    } else if (_imageSelected != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width * 9) / 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.file(_imageSelected).image),
        ),
      );
    } else if (_imageUrl != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width * 9) / 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (_imageUrl != '') ? Image.network(_imageUrl).image : kEventDefaultImage
          ),
        ),
      );
    } else {
      return null;
    }
  }

  Future<void> _selectPicture(ImageSource source) async {
    final pickedFile = await pickerBack.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
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
                _currentEvent.field = _currentEvent.fieldsList[0];
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
                    color: (_currentEvent.field == _currentEvent.fieldsList[0]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentEvent.field = _currentEvent.fieldsList[1];
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
                    color: (_currentEvent.field == _currentEvent.fieldsList[1]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentEvent.field = _currentEvent.fieldsList[2];
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
                    color: (_currentEvent.field == _currentEvent.fieldsList[2]) ? kOrangeMainColor : kWhiteColor,
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentEvent.field = _currentEvent.fieldsList[3];
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
                    color: (_currentEvent.field == _currentEvent.fieldsList[3]) ? kOrangeMainColor : kWhiteColor,
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
      _currentEvent.title = value.capitalize();
      return null;
    }
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentEvent.description = value;
      return null;
    }
  }

  String _validateAddress(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentEvent.address = value;
      return null;
    }
  }


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      locale: Locale("fr"),
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year),
      lastDate: DateTime(_selectedDate.year + 2),
      helpText: 'Sélectionner une date',
      cancelText: 'Annuler',
      confirmText: 'Valider',
      errorFormatText: 'Entrer une date valide',
      errorInvalidText: 'Entrer une date dans l\'intervalle autorisé',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: _actualTime,
      cancelText: 'Annuler',
      confirmText: 'Valider',
      helpText: 'Sélectionner une heure',
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          ),
        );
      },
    );
    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
      });
  }

  String _validateDate(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentEvent.date = DateHelper().fromDateTimeToInt(_selectedDate);
      return null;
    }
  }

  String _validateTime(String value) {
      if (value.isEmpty) {
        return 'Champ requis';
      }
      return null;
  }

  _saveEvent(Event event) {
    if(_formKey.currentState.validate()){
      _eventDate = DateHelper().mergeDateAndTime(_selectedDate, _selectedTime);
      event.date = _eventDate.millisecondsSinceEpoch.toInt();
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      DiapasonApi().uploadEvent(eventNotifier, event, _imageSelected);
      Navigator.pop(context);
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _dateController?.dispose();
    _timeController?.dispose();
    _addressController?.dispose();
    super.dispose();
  }

  Widget _showEventPrice() {
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
          left: 5.0,
          right: 5.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: kBlueGreyColor,
                  activeTrackColor: kOrangeMainColor,
                  thumbColor: kOrangeAccentColor,
                  overlayColor: kBlueAccentColor.withOpacity(0.4),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 15.0,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 25.0,
                  ),
                ),
                child: Slider(
                    value: _currentEvent.price.toDouble(),
                    min: 0.0,
                    max: 50.0,
                    onChanged: (double newValue) {
                      setState(() {
                        _currentEvent.price = newValue.toInt();
                      });
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: NumberText('${_currentEvent.price.toString()} €'),
            )
          ],
        ),
      ),
    );
  }

  Widget _showEventCapacity() {
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
          left: 5.0,
          right: 5.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: kBlueGreyColor,
                  activeTrackColor: kOrangeMainColor,
                  thumbColor: kOrangeAccentColor,
                  overlayColor: kBlueAccentColor.withOpacity(0.4),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 15.0,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 25.0,
                  ),
                ),
                child: Slider(
                    value: _currentEvent.capacity.toDouble(),
                    min: _capacity,
                    max: 50.0,
                    onChanged: (double newValue) {
                      setState(() {
                        _currentEvent.capacity = newValue.toInt();
                      });
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: NumberText('${_currentEvent.capacity.toString()}'),
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: (_currentEvent.eid != null)
            ? UpdateAppBarText('Modifier l\'événement')
            : UpdateAppBarText('Créer un événement'),
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
        centerTitle: true, // android override
        elevation: 0.0,
        actions: <Widget>[
          AppBarDecorationIcon(icon: FontAwesomeIcons.calendarAlt)
        ],
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        AlertHelper().showPictureOptions(
                          context,
                              () => _selectPicture(ImageSource.camera),
                              () => _selectPicture(ImageSource.gallery),
                        );
                      },
                      child: _showImage(),
                    ),
                    _showFields(kDrawerDividerColor),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0,),
                      child: Center(
                        child: RegulationRegularText(
                          _currentEvent.field,
                          fontSize: 18.0,
                          color: kOrangeMainColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: kWhiteColor),
                        child: TextFormField(
                          style: TextStyle(color: kWhiteColor),
                          initialValue: _currentEvent.title,
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
                          initialValue: _currentEvent.description,
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
                            labelText: 'Description',
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0,),
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 22.0),
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 19.0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: kWhiteColor),
                        child: TextFormField(
                            style: TextStyle(color: kWhiteColor),
                          controller: _timeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTap: () async {
                            await _selectTime(context);
                            setState(() {
                              _timeController.text =
                              '${_selectedTime.format(context)}';
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
                            labelText: 'Heure de début',
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
                              Icons.timer,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateTime
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'Participation aux frais',
                        fontSize: 18.0,
                      ),
                    ),
                    _showEventPrice(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'Places disponibles',
                        fontSize: 18.0,
                      ),
                    ),
                    _showEventCapacity(),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: GenericButton(
                          label: 'Valider',
                          buttonColor: kOrangeAccentColor,
                          onTap: () {
                            _saveEvent(_currentEvent);
                          }
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
