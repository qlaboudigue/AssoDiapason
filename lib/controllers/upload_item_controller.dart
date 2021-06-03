import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadItemController extends StatefulWidget {
  @override
  _UploadItemControllerState createState() => _UploadItemControllerState();
}

class _UploadItemControllerState extends State<UploadItemController> {

  // STATE PROPERTIES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Item _currentItem;

  // Properties managing images
  String _imageOneUrl;
  File _imageOneSelected;
  final imageOnePicker = ImagePicker();

  // Properties managing images
  String _imageTwoUrl;
  File _imageTwoSelected;
  final imageTwoPicker = ImagePicker();

  // Properties managing images
  String _imageThreeUrl;
  File _imageThreeSelected;
  final imageThreePicker = ImagePicker();

  // Properties managing background image
  String _iconImageUrl;
  File _iconImageSelected;
  final iconPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load in local variable _currentStory the Notifier's Current Story or an empty instance
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Load current user into current activity leader
    if (itemNotifier.currentItem != null) {
      // UPDATE CASE
      _currentItem = itemNotifier.currentItem;
    } else {
      // NEW ITEM CASE
      _currentItem = Item();
      _currentItem.iconImageUrl = '';
      _currentItem.imageOneUrl = '';
      _currentItem.imageTwoUrl = '';
      _currentItem.imageThreeUrl = '';
      _currentItem.owner = memberNotifier.currentMember.uid;
      _currentItem.state = _currentItem.itemState[1];
      _currentItem.loanTerm = _currentItem.loanTerms[0];
      _currentItem.price = 0;
    }
    // SHARED CASE
    _imageOneUrl = _currentItem.imageOneUrl;
    _imageTwoUrl = _currentItem.imageTwoUrl;
    _imageThreeUrl = _currentItem.imageThreeUrl;
    _iconImageUrl = _currentItem.iconImageUrl; // Null in case of a creation, URL String in case of an update
  }

  Future<void> _selectImageOne(ImageSource source) async {
    final pickedFile = await imageOnePicker.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _imageOneSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _selectImageTwo(ImageSource source) async {
    final pickedFile = await imageTwoPicker.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _imageTwoSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _selectImageThree(ImageSource source) async {
    final pickedFile = await imageThreePicker.getImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    if (pickedFile != null) {
      setState(() {
        _imageThreeSelected = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  Widget _imageTile(String imageUrl, File imageSelected, Function selectPicture, int index) {
    if(imageUrl != null) {
      if(imageUrl == '' && imageSelected == null) {
        return GestureDetector(
          onTap: selectPicture,
          child: Container(
              decoration: BoxDecoration(
                color: kDrawerDividerColor,
                border: Border.all(
                  // color: kOrangeMainColor,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.camera_enhance_rounded,
                    size: 35.0,
                    color: kOrangeMainColor,
                  ),
                  SizedBox(height: 5.0),
                  NumberText('n° ${index.toString()}'),
                ],
              )),
        );
      } else if (imageSelected != null) {
        return GestureDetector(
          onTap: selectPicture,
          child: Container(
            decoration: BoxDecoration(
              color: kDrawerDividerColor,
              border: Border.all(
                // color: kOrangeMainColor,
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.file(imageSelected).image
              ),
            ),
          ),
        );
      } else if (imageUrl != '') {
        return GestureDetector(
          onTap: selectPicture,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  color: kDrawerDividerColor,
                  border: Border.all(),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  )
              ),
            ),
            placeholder: (context, url) =>
                MediumImagePlaceholderWidget(),
            errorWidget: (context, url, error) =>
                ItemDefaultImageWidget(),
            // ActivityBackgroundDefaultImage(),
          ),
        );
      } else {
        return EmptyContainer();
      }
    } else {
      return EmptyContainer();
    }
  }

  Widget _buildImagesGrid() {
    List<Widget> _imageTiles = [
      _imageTile(
          _imageOneUrl,
          _imageOneSelected,
          () {
            AlertHelper().showPictureOptions(
              context,
                  () => _selectImageOne(ImageSource.camera),
                  () => _selectImageOne(ImageSource.gallery),
            );
          },
          1),
      _imageTile(
          _imageTwoUrl,
          _imageTwoSelected,
              () {
            AlertHelper().showPictureOptions(
              context,
                  () => _selectImageTwo(ImageSource.camera),
                  () => _selectImageTwo(ImageSource.gallery),
            );
          },
          2),
      _imageTile(
          _imageThreeUrl, _imageThreeSelected,
              () {
            AlertHelper().showPictureOptions(
              context,
                  () => _selectImageThree(ImageSource.camera),
                  () => _selectImageThree(ImageSource.gallery),
            );
            },
          3),
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 0,
      children: _imageTiles,
    );
  }


  Widget _showIconImage() {
    if(_iconImageUrl != null) {
      if (_iconImageUrl == '' && _iconImageSelected == null) {
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
                  size: 35.0,
                  color: kOrangeMainColor,
                ),
                SizedBox(height: 5.0),
                NumberText('Icône'),
              ],
            ));
      } else if (_iconImageSelected != null) {
        return Container(
          width: 130.0,
          height: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                fit: BoxFit.cover, image: Image.file(_iconImageSelected).image),
          ),
        );
      } else if (_iconImageUrl != '') {
        return CachedNetworkImage(
          imageUrl: _iconImageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
              )
            ),
          ),
          placeholder: (context, url) =>
              MediumImagePlaceholderWidget(),
          errorWidget: (context, url, error) =>
              ItemDefaultImageWidget(),
          // ActivityBackgroundDefaultImage(),
        );
      } else {
        return EmptyContainer();
      }
    } else {
      return EmptyContainer();
    }
  }

  Future<void> _selectIconPicture(ImageSource source) async {
    final pickedFile = await iconPicker.getImage(
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
      _currentItem.name = value.capitalize();
      return null;
    }
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentItem.description = value.capitalize();
      return null;
    }
  }

  Widget _showItemState() {
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
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              ),
            ),
            dropdownColor: kDrawerDividerColor,
            value: _currentItem.state,
            onChanged: (newValue) {
              setState(() {
                _currentItem.state = newValue;
              });
            },
            items: _currentItem.itemState
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SharedDropDownTextWidget(text: value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _showLoanTerm() {
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
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              ),
            ),
            dropdownColor: kDrawerDividerColor,
            value: _currentItem.loanTerm,
            onChanged: (newValue) {
              setState(() {
                _currentItem.loanTerm = newValue;
              });
            },
            items: _currentItem.loanTerms
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SharedDropDownTextWidget(text: value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _showLoanPrice() {
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
                    value: _currentItem.price.toDouble(),
                    min: 0.0,
                    max: 50.0,
                    onChanged: (double newValue) {
                      setState(() {
                        _currentItem.price = newValue.toInt();
                      });
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: NumberText('${_currentItem.price.toString()} €'),
            )
          ],
        ),
      ),
    );
  }

  void _saveItem(Item item) {
    if (_formKey.currentState.validate()) {
      ItemNotifier itemNotifier =
          Provider.of<ItemNotifier>(context, listen: false);
      MemberNotifier memberNotifier =
          Provider.of<MemberNotifier>(context, listen: false);
      DiapasonApi().uploadItem(
          itemNotifier, item, _imageOneSelected, _imageTwoSelected, _imageThreeSelected, _iconImageSelected, memberNotifier);
      Navigator.pop(context);
    } else {
      // "Required fields" appears in the form
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: (_currentItem.iId != null)
              ? UpdateAppBarText('Modifier l\'objet')
              : UpdateAppBarText('Ajouter un objet'),
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
            Container(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.tools,
                    color: kDrawerDividerColor,
                    size: 25.0,
                  ),
                ))
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
                    Container(
                      child: _buildImagesGrid(),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
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
                                child: _showIconImage()
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      primaryColor: kWhiteColor,
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(color: kWhiteColor),
                                      initialValue: _currentItem.name,
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                        labelText: 'Nom de l\'objet',
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
                                      validator: _validateName,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: Theme(
                                    data: Theme.of(context)
                                        .copyWith(primaryColor: kWhiteColor),
                                    child: TextFormField(
                                      style: TextStyle(color: kWhiteColor),
                                      initialValue: _currentItem.description,
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLength: 40,
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
                                        labelText: 'Fonction et usages',
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
                                          Icons.category,
                                          color: kOrangeMainColor,
                                        ),
                                      ),
                                      validator: _validateDescription,
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
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'État',
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                        child: _showItemState()
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'Conditions de prêt',
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                        child: _showLoanTerm()
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'Frais d\'utilisation',
                        fontSize: 18.0,
                      ),
                    ),
                    Container(child: _showLoanPrice()),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: GenericButton(
                          label: 'Valider',
                          buttonColor: kOrangeAccentColor,
                          onTap: () {
                            _saveItem(_currentItem);
                          }),
                    ),
                  ],
                )),
          ),
        ));
  }
}
