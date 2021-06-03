import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/user_notifier.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_widgets/main_app_navigation_item.dart';
import 'package:provider/provider.dart';

class MainAppController extends StatefulWidget {
  static String route = 'main_app_controller';

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {

  int _currentIndex = 0;
  bool _triedFetching = false;
  Timer timer;

  @override
  void initState() {
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Create empty instance
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    DiapasonApi().getMe(userNotifier, memberNotifier);
    DiapasonApi().getMembersShip(memberNotifier);
    DiapasonApi().getMembersAdmin(memberNotifier);
    super.initState();
  }

  Future<void> _initApp() async {
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false); // Create empty instance
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getMe(userNotifier, memberNotifier);
      DiapasonApi().getMembersShip(memberNotifier);
      DiapasonApi().getMembersAdmin(memberNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberNotifier>(
      builder: (context, memberNotifier, child) {
        if(memberNotifier.currentMember != null) {
          return Scaffold(
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
              ),
              child: DrawerGeneral(),
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: [
                for (final tabItem in MainAppNavigationItem.items)
                  tabItem.screen,
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 200),
              animationCurve: Curves.bounceInOut,
              backgroundColor: kOrangeMainColor,
              buttonBackgroundColor: kBarBackgroundColor,
              color: kBarBackgroundColor,
              height: 65.0,
              index: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: <Widget>[
                for (final tabItem in MainAppNavigationItem.items) tabItem.icon,
              ],
            ),
          );
        } else {
          timer = Timer(Duration(seconds: 3), () {
            setState(() {
              _triedFetching = true;
            });
          });
          return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kBarBackgroundColor,
                elevation: 10.0,
                centerTitle: true, // android override
                title: Image.asset(
                  kHomeLogoPicture,
                  fit: BoxFit.contain,
                  height: 40.0,
                ),
              ),
              body: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: (_triedFetching == false)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: kWhiteColor,
                        valueColor: AlwaysStoppedAnimation<Color>(kOrangeMainColor),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: RegulationRegularText('...Chargement')),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        width: 110.0,
                        height: 110.0,
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Icon(
                          Icons.report_gmailerrorred_outlined,
                          size: 70.0,
                          color: kOrangeDeepColor,
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: RegulationRegularText(
                              'Oops, une erreur est survenue de notre côté et nous en sommes désolés',
                              alignment: TextAlign.center,
                              fontSize: 20.0,
                              color: kSubTextColor,
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                        child: GenericButton(
                            label: 'Réessayer',
                            buttonColor: kOrangeDeepColor,
                            onTap: () async {
                              setState(() {
                                _triedFetching = false;
                              });
                              await _initApp();
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        }
      },
    );
  }
}