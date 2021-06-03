import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/sign_in_controller.dart';
import 'package:diapason/models/auth_user.dart';
import 'package:diapason/notifier/user_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:diapason/controllers/main_app_controller.dart';
import 'package:diapason/controllers/forgot_password_controller.dart';
import 'package:provider/provider.dart';


class LoginController extends StatefulWidget {

  // String used for routes Navigation through app
  static String route = 'login_controller';

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  User user;

  bool _showSpinner = false;

  bool _logError = false;
  String _errorMessage = '';

  AuthUser _authUser = AuthUser();

  TextEditingController _mailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    UserNotifier authNotifier = Provider.of<UserNotifier>(context, listen: false);
    DiapasonApi().initializeCurrentUser(authNotifier);
    super.initState();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
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

  String _validateExistingPassword(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    }
    return null;
  }
  
  @override
  void dispose() {
    _mailController?.dispose();
    _passwordController?.dispose();
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
          body: ModalProgressHUD(
            color: kDarkGreyColor.withOpacity(0.5),
            opacity: 0.5,
            inAsyncCall: _showSpinner,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: kOrangeDarkColor,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDB474)),
            ),
            child: InkWell(
              onTap: (() => FocusScope.of(context).requestFocus(FocusNode())), // Remove Keyboard by taping outside
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Image.asset(
                            'images/whiteLogo.png',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0,),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: kBlueMainColor),
                          child: TextFormField(
                            enableSuggestions: false,
                            controller: _mailController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: _logError,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Identifiant',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: kBlueMainColor,
                              ),
                            ),
                            validator: _validateEmail
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0,),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: kBlueMainColor),
                          child: TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            obscureText: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: kBlueMainColor,
                              ),
                            ),
                            validator: _validateExistingPassword,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: _logError ? ErrorText(_errorMessage) : EmptyContainer(),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 5.0,),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordController()));
                                    },
                                    child: HomeSubText(
                                      'Mot de passe oublié ?',
                                    )
                                ),
                            ),
                            SizedBox(width: 30.0,),
                            Container(
                              padding: EdgeInsets.only(top: 5.0,),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => SignInController()));
                                },
                                child: Row(
                                  children: <Widget>[
                                    HomeSubText(
                                      'Créer un compte'
                                    ),
                                    SizedBox(width: 5.0,),
                                    Icon(Icons.follow_the_signs, color: kBlueMainColor,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        child: HomeButton(
                              label: 'Se connecter',
                              buttonColor: kOrangeDeepColor,
                              buttonIcon: Icons.lock_open,
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  // Step 1 : Loading
                                  setState(() {
                                    _showSpinner = true;
                                  });
                                  // Step 2 : Get entry Strings
                                  _authUser.email = _mailController.text;
                                  _authUser.password = _passwordController.text;
                                  // Step 3 : Try Loging and get user
                                  try {
                                    UserCredential credentialUser = await _auth.signInWithEmailAndPassword(email: _authUser.email, password: _authUser.password);
                                    user = credentialUser.user;
                                  } catch (error) {
                                    setState(() {
                                      _showSpinner = false;
                                      _logError = true;
                                      _passwordController.clear();
                                      _errorMessage = 'Identifiant ou mot de passe incorrect';
                                    });
                                    // print(error);
                                  }
                                  if(user != null && user.emailVerified == true) {
                                    // Step 4 : Clear error message, Clear text fields, Connection and push MainAppController, Spinner off
                                    _mailController.clear();
                                    _passwordController.clear();
                                    // print(user);
                                    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
                                    userNotifier.currentUser = user; // Client action necessary for main app controller init
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainAppController()));
                                    // Navigator.pushNamed(context, MainAppController.route);
                                    setState(() {
                                      _logError = false;
                                      _showSpinner = false;
                                    });
                                  } else if (user != null && user.emailVerified == false){
                                    // User exists but did not validate mail address
                                    // Send email for verification and push account creation
                                    try {
                                      // Clear error message, Clear text fields, SignIn, Send email verification mail and push Create Account
                                      setState(() {
                                        _showSpinner = false;
                                        _logError = true;
                                        _errorMessage = 'Utilisateur non vérifié';
                                      });
                                      await user.sendEmailVerification();
                                      AlertHelper().alertVerificationMailSending(context);
                                    } catch (error) {
                                        // print(error);
                                        setState(() {
                                          _showSpinner = false;
                                          _logError = true;
                                          _errorMessage = 'Utilisateur non vérifié';
                                        });
                                      return null;
                                    }
                                  } else {
                                    return null;
                                  }
                                }
                              }
                          ),
                        ),
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

