import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/auth_user.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/views/my_widgets/home_text.dart';
import 'package:diapason/views/pages/convention_page.dart';
import 'package:diapason/views/pages/data_policy_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class SignInController extends StatefulWidget {
  @override
  _SignInControllerState createState() => _SignInControllerState();
}

class _SignInControllerState extends State<SignInController> {

  final _auth = FirebaseAuth.instance;
  UserCredential credentialUser;
  User user; // Instance de l'authentificateur

  final _formKey = GlobalKey<FormState>();

  AuthUser _authUser = AuthUser();

  bool _isOneSwitched = false;
  bool _isTwoSwitched = false;

  bool _verificationError = false;
  String _verificationMessage;

  TextEditingController _mailController;
  TextEditingController _passwordController;
  TextEditingController _passwordCopyController;

  @override
  void initState() {
    super.initState();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordCopyController = TextEditingController();
  }

  String _validateNewPassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Champ requis';
    } else if (!regex.hasMatch(value)) {
      return 'Minimum 8 lettres avec majuscule, minuscule et chiffre';
    } else
      return null;
  }

  String _validatePasswordCopy(String value) {
    if (value != _passwordController.text) {
      return 'Le mot de passe est différent';
    } else if (value.isEmpty) {
      return 'Champ requis';
    } else {
      return null;
    }
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
    _mailController?.dispose();
    _passwordController?.dispose();
    _passwordCopyController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/loginBackground.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true, // android override
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: AppBarSubTextWidget(
              text: 'Créer un compte',
              color: kBlueMainColor,
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                  color: kBlueMainColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Center(
                    child: Icon(
                      Icons.person_add,
                      color: kWhiteColor,
                      size: 25.0,
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: InkWell(
                onTap: (() => FocusScope.of(context).requestFocus(
                    FocusNode())), // Remove Keyboard by taping outside
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                        child: HomeText(
                          'Entrez votre adresse mail et un mot de passe '
                          'contenant minimum 8 caractères avec au moins une majuscule et un chiffre.',
                          alignment: TextAlign.center,
                          color: kBlueMainColor,
                          fontSize: 20.0,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(primaryColor: kBlueMainColor),
                              child: TextFormField(
                                  controller: _mailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
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
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(primaryColor: kBlueMainColor),
                              child: TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: false,
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: kBlueMainColor,
                                    ),
                                  ),
                                  validator: _validateNewPassword),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(primaryColor: kBlueMainColor),
                              child: TextFormField(
                                  controller: _passwordCopyController,
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: false,
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Confirmez le mot de passe',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: kBlueMainColor,
                                    ),
                                  ),
                                  validator: _validatePasswordCopy),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                        // margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kWhiteColor,
                                  inactiveThumbColor: kBlueMainColor,
                                  activeTrackColor: kOrangeDeepColor,
                                  value: _isOneSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      _isOneSwitched = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ConventionPage.route);
                              },
                              child: HomeUnderlinedText(
                                'J\'ai lu et j\'accepte les conditions d\'utilisation',
                                color: kBlueMainColor,
                                fontSize: 18.0,
                              ),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                        // margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                  activeColor: kWhiteColor,
                                  inactiveThumbColor: kBlueMainColor,
                                  activeTrackColor: kOrangeDeepColor,
                                  value: _isTwoSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      _isTwoSwitched = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PrivacyPolicyPage.route);
                              },
                              child: HomeUnderlinedText(
                                'J\'ai lu et j\'accepte la politique de confidentialité',
                                color: kBlueMainColor,
                                fontSize: 18.0,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                        child: _verificationError
                            ? ErrorText(_verificationMessage)
                            : Container(width: 0.0, height: 0.0),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: HomeButton(
                            label: 'Valider mon inscription',
                            buttonColor: kOrangeDeepColor,
                            buttonIcon: Icons.follow_the_signs,
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                if (_isOneSwitched == true &&
                                    _isTwoSwitched == true) {
                                  // Set email for Sign in
                                  _authUser.email = _mailController.text;
                                  _authUser.password = _passwordController.text;
                                  try {
                                    credentialUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: _authUser.email,
                                            password: _authUser.password);
                                    user = credentialUser.user;
                                  } catch (error) {
                                    // Create user related error 1 : email-already-in-use
                                    print(error);
                                    _passwordController.clear();
                                    _passwordCopyController.clear();
                                    setState(() {
                                      _verificationError = true;
                                      _verificationMessage =
                                          'Ce compte existe déjà ou une erreur s\'est produite.';
                                    });
                                    return null;
                                  }
                                  if (user != null) {
                                    try {
                                      await user.sendEmailVerification();
                                      AlertHelper()
                                          .witnessVerificationMailSending(
                                              context); // Send verification mail
                                      DiapasonApi()
                                          .addMemberFromAccountCreation(user);
                                      // FireHelper().addMemberFromAccountCreation(user); // Add user related member in ddb
                                      // Navigator.pop(context);// Will pop to login screen
                                      setState(() {
                                        _verificationError =
                                            false; // Clean error message eventually
                                      });
                                    } catch (error) {
                                      setState(() {
                                        _verificationError = true;
                                        _verificationMessage =
                                            'Une erreur s\'est produite, veuillez réessayer.';
                                      });
                                    }
                                  }
                                } else {
                                  setState(() {
                                    _verificationError = true;
                                    _verificationMessage =
                                        'Veuillez accepter nos conditions d\'utilisation et la politique de confidentialité';
                                  });
                                }
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
