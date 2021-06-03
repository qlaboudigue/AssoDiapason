import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/views/pages/convention_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadClaimController extends StatefulWidget {
  static String route = 'report_content_page';

  @override
  _UploadClaimControllerState createState() => _UploadClaimControllerState();
}

class _UploadClaimControllerState extends State<UploadClaimController> {
  final _formKey = GlobalKey<FormState>();

  Claim _currentClaim;

  bool _hasNoOption = false;

  @override
  void initState() {
    ClaimNotifier claimNotifier =
        Provider.of<ClaimNotifier>(context, listen: false);
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    super.initState();
    if (claimNotifier.currentClaim != null &&
        memberNotifier.currentMember != null) {
      // COMPLETION CASE
      _currentClaim = claimNotifier.currentClaim;
    } else {
      // NEW CLAIM CASE FROM DRAWER
      _currentClaim = Claim();
      _currentClaim.type = _currentClaim.claimTypeList[0];
    }
    _currentClaim.isHate = false;
    _currentClaim.isSexual = false;
    _currentClaim.isDelusive = false;
    _currentClaim.isCopyrighted = false;
  }

  int _calculateSeverity(Claim claim) {
    int _severity = 0;
    if (claim.isHate == true) {
      _severity++;
    }
    if (claim.isSexual == true) {
      _severity++;
    }
    if (claim.isDelusive == true) {
      _severity++;
    }
    if (claim.isCopyrighted == true) {
      _severity++;
    }
    return _severity;
  }

  String _validateContent(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentClaim.content = value;
      return null;
    }
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    } else {
      _currentClaim.description = value;
      return null;
    }
  }

  bool hasNoOption(Claim claim) {
    if (claim.isHate == true ||
        claim.isSexual == true ||
        claim.isDelusive == true ||
        claim.isCopyrighted == true) {
      _hasNoOption = false;
      return false;
    } else {
      _hasNoOption = true;
      return true;
    }
  }

  Widget _showClaimType() {
    return Container(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
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
            value: _currentClaim.type,
            onChanged: (newValue) {
              setState(() {
                _currentClaim.type = newValue;
              });
            },
            items: _currentClaim.claimTypeList
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
  }


  _saveClaim(Claim claim) {
    if (_formKey.currentState.validate() && hasNoOption(claim) == false) {
      // print(_currentClaim.content);
      // Post Date
      int _claimDate = DateTime.now().millisecondsSinceEpoch.toInt();
      _currentClaim.date = _claimDate;
      // Initial Status
      String _claimStatus = _currentClaim.claimStatusList[0];
      _currentClaim.status = _claimStatus;
      // Severity
      _currentClaim.severity = _calculateSeverity(_currentClaim);
      ClaimNotifier claimNotifier =
          Provider.of<ClaimNotifier>(context, listen: false);
      DiapasonApi().uploadClaim(claimNotifier, claim);
      AlertHelper().witnessClaimCreation(context);
    } else {
      setState(() {
        // print(hasNoOption(claim));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Signaler un contenu'),
        iconTheme: IconThemeData(
          color: kOrangeMainColor, //change your color here
        ),
        backgroundColor: kBarBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.cancel,
              size: 30.0,
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
                  FontAwesomeIcons.angry,
                  color: kDrawerDividerColor,
                  size: 25.0,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: Column(
                      children: <Widget>[
                        SharedRegularTextWidget(
                          'Vous avez été témoin d\'un contenu inapproprié sur l\'application Diapason ? '
                          'Veuillez remplir le formulaire ci-dessous. Notre équipe de modérateurs.trices '
                          'examinera votre demande sous les 24 heures pour évaluer si le contenu enfreint nos',
                          color: kWhiteColor,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ConventionPage.route);
                            },
                            child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 10.0, top: 9.0),
                                child: UnderlinedLinkedText(
                                  'Conditions d\'utilisations',
                                  color: kOrangeMainColor,
                                  fontSize: 20.0,
                                ))),
                        SharedRegularTextWidget(
                          'Si le contenu est jugé inapproprié, il sera alors retiré de l\'application '
                          'et son auteur, exclu.',
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                          style: TextStyle(color: kWhiteColor),
                          initialValue: _currentClaim.content,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 40,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: kWhiteColor),
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
                            labelText: 'Intitulé du contenu',
                            prefixIcon: Icon(
                              Icons.info_outline,
                              color: kOrangeMainColor,
                            ),
                          ),
                          validator: _validateContent),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      child: RegulationRegularText(
                        'Le contenu concerne un(e) :',
                        color: kSubTextColor,
                      )),
                  _showClaimType(),
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        (_hasNoOption == true)
                            ? RegulationRegularText(
                                '*',
                                color: kRedAccentColor,
                              )
                            : EmptyContainer(),
                        RegulationRegularText(
                          'Sélectionnez minimum un critère :',
                          color: kSubTextColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kOrangeAccentColor,
                                  inactiveThumbColor: kOrangeMainColor,
                                  inactiveTrackColor: kDrawerDividerColor,
                                  value: _currentClaim.isHate,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      _currentClaim.isHate = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: RegulationRegularText(
                              'Apologie de la haine, de la violence, et/ou du terrorisme',
                              color: kWhiteColor,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kOrangeAccentColor,
                                  inactiveThumbColor: kOrangeMainColor,
                                  inactiveTrackColor: kDrawerDividerColor,
                                  value: _currentClaim.isSexual,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      _currentClaim.isSexual = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: RegulationRegularText(
                              'Références à caractère sexuel',
                              color: kWhiteColor,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kOrangeAccentColor,
                                  inactiveThumbColor: kOrangeMainColor,
                                  inactiveTrackColor: kDrawerDividerColor,
                                  value: _currentClaim.isDelusive,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      _currentClaim.isDelusive = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: RegulationRegularText(
                              'Constitue de fausse informations ou un comportement trompeur',
                              color: kWhiteColor,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kOrangeAccentColor,
                                  inactiveThumbColor: kOrangeMainColor,
                                  inactiveTrackColor: kDrawerDividerColor,
                                  value: _currentClaim.isCopyrighted,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      _currentClaim.isCopyrighted = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: RegulationRegularText(
                              'Ne respecte pas le droit de propriété intellectuelle',
                              color: kWhiteColor,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kWhiteColor),
                      child: TextFormField(
                          style: TextStyle(color: kWhiteColor),
                          initialValue: _currentClaim.description,
                          maxLines: 1,
                          maxLength: 100,
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
                            labelText:
                                'Détaillez vos raisons',
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
                              Icons.list_alt,
                              color: kOrangeMainColor,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _validateDescription),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: GenericButton(
                        label: 'Envoyer',
                        buttonColor: kOrangeAccentColor,
                        onTap: () {
                          _saveClaim(_currentClaim);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
