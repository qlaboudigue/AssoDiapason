import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends StatefulWidget {

  @override
  _ForgotPasswordControllerState createState() =>
      _ForgotPasswordControllerState();
}

class _ForgotPasswordControllerState extends State<ForgotPasswordController> {

  // State properties
  final _formKey = GlobalKey<FormState>();

  TextEditingController _mailBackUpController;

  bool _isMailSent = false;

  // Methods
  @override
  void initState() {
    super.initState();
    _mailBackUpController = TextEditingController();
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Champ requis';
    } else if (!regex.hasMatch(value)) {
      return 'L\'adresse mail est invalide';
    } else
      return null;
  }

  @override
  void dispose() {
    _mailBackUpController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: kLogImage,
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: AppBarSubTextWidget(
            text: 'Réinitialiser le mot de passe',
            color: kBlueMainColor,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30.0,
                color: kBlackColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: Icon(
                    Icons.find_replace,
                    color: kWhiteColor,
                    size: 25.0,
                  ),
                ))
          ],
        ),
        body: (_isMailSent == true)
            ? SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Icon(
                              Icons.forward_to_inbox,
                              size: 60.0,
                              color: kOrangeDeepColor,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0),
                              child: HeadlineOneText(
                                'Consultez vos mails',
                                color: kBlueMainColor,
                                alignment: TextAlign.center,
                              )),
                          Container(
                              // color: Colors.blue,
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 15.0),
                              child: HeadlineTwoText(
                                'Nous venons de vous envoyer les instructions pour réinitialiser votre mot de passe',
                                color: kBlueMainColor,
                                alignment: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                        child: Column(
                          children: <Widget>[
                            HeadlineThreeText(
                              'Vous n\'avez pas reçu l\'email ? Vérifiez vos spams',
                              alignment: TextAlign.center,
                              color: kBlueMainColor,
                            ),
                            HeadlineThreeText(
                              'ou',
                              alignment: TextAlign.center,
                              color: kBlueMainColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isMailSent = false;
                                });
                              },
                              child: HeadlineThreeText(
                                'réessayez avec une autre adresse',
                                alignment: TextAlign.center,
                                color: kRedAccentColor,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
            )
            : SingleChildScrollView(
                child: InkWell(
                  onTap: (() => FocusScope.of(context).requestFocus(FocusNode())), // Remove Keyboard by taping outside
                  child: SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10.0),
                                child: HomeText(
                                  'Indiquez l\'adresse mail associée à votre compte et nous allons vous envoyer un email avec les instructions pour réinitialiser votre mot de passe',
                                  alignment: TextAlign.center,
                                  color: kBlueMainColor,
                                  fontSize: 20.0,
                                ),
                              ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15.0),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(primaryColor: kBlueMainColor),
                              child: TextFormField(
                                  controller: _mailBackUpController,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse mail',
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: kBlueMainColor,
                                    ),
                                  ),
                                  validator: _validateEmail),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: LoginButton(
                                label: 'Envoyer',
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    String _mail = _mailBackUpController.text;
                                    DiapasonApi().resetPassword(_mail);
                                    // FireHelper().resetPassword(_mail);
                                    setState(() {
                                      _isMailSent = true;
                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

}
