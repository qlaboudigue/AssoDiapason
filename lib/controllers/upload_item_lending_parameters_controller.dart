import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadItemLendingParametersController extends StatefulWidget {

  @override
  _UploadItemLendingParametersControllerState createState() => _UploadItemLendingParametersControllerState();
}

class _UploadItemLendingParametersControllerState extends State<UploadItemLendingParametersController> {

  // PROPERTIES
  Item _currentItem;
  Member _currentBorrower;

  // METHODS
  @override
  void initState() {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    if(itemNotifier.currentItem != null) {
      _currentItem = itemNotifier.currentItem;
    }
    super.initState();
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
                fontSize: 20.0,
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

  Widget _showLoanTerm(){
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
              // isDense: true,
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

  Widget _showMembershipList(){
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
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
            // Useful in case of hint text
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: kDropDownFontSize,
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              ),
            ),
            dropdownColor: kDrawerDividerColor,
            value: _currentBorrower,
            onChanged: (newValue) {
              setState(() {
                _currentBorrower = newValue;
              });
            },
            hint: Text(
              'Sélectionnez un adhérent',
              style: TextStyle(
                color: kWhiteColor,
              ),
            ),
            items: memberNotifier.membersShipList
                .map<DropdownMenuItem<Member>>((Member member) {
              return DropdownMenuItem<Member>(
                value: member,
                child: SharedDropDownTextWidget(text: '${member.forename.capitalize()} ${member.name.capitalize()}'),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _saveItem(Item item, Member borrower) {
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    DiapasonApi().uploadItemLendingParameters(itemNotifier, memberNotifier, item, borrower);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Prêter l\'objet'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
              color: kOrangeMainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                child: SharedSubTextWidget('État', fontSize: 18.0,),
              ),
              _showItemState(),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget('Conditions de prêt', fontSize: 18.0,),
              ),
              _showLoanTerm(),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget('Frais d\'utilisation', fontSize: 18.0,),
              ),
              _showLoanPrice(),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget('Possesseur actuel', fontSize: 18.0,),
              ),
              _showMembershipList(),
              Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: GenericButton(
                    label: 'Mettre à jour',
                    buttonColor: kOrangeAccentColor,
                    onTap: () {
                      _saveItem(_currentItem, _currentBorrower);
                    }
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
