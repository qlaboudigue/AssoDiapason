import 'dart:async';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/activity.dart';
import 'package:diapason/models/event.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';

class AlertHelper {

  Timer _timer;

  // SHARED

  void showPictureOptions(BuildContext context, Function callBackOne, Function callBackTwo) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: kDrawerBackgroundColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0, top: 20.0, left: 20.0, right: 20.0),
                      child: InkWell(
                        onTap: callBackOne,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.camera,
                              size: 30.0,
                              color: kOrangeMainColor,
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: AlertChoiceRegularText(text: 'Prendre une photo'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: kDrawerDividerColor,
                      thickness: 1.5,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: InkWell(
                        onTap: callBackTwo,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.filter,
                              size: 30.0,
                              color: kOrangeMainColor,
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: AlertChoiceRegularText(text:
                                  'Choisir dans la galerie'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              AlertCancelButton(),
            ]),
          );
        });
  }

  // LOGIN

  Future<void> alertVerificationMailSending(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 4), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: AlertRegularText(
                'Un email vous a été envoyé. Après validation de votre adresse, vous pouvez vous connecter. '
                    '(Si vous n\'avez rien reçu, pensez à consulter les spams)',
              ),
            ),
          );
        }
    ).then((value){
      if(_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  Future<void> witnessVerificationMailSending(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 4), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: AlertRegularText(
                'Un email vous a été envoyé. Après validation de votre adresse, vous pouvez vous connecter. '
                    '(Si vous n\'avez rien reçu, pensez à consulter les spams)',
              ),
            ),
          );
        }
    ).then((value){
      if(_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  // MEMBER PROFILE

  Future<void> clearBlackListedMember(BuildContext context, MemberNotifier memberNotifier, String blackListedUid) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            // title: AlertRegularText('Supprimer l\'événement'),
            content: AlertRegularText('Êtes-vous certain.e de vouloir débloquer ce membre ?'),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: AlertValidationText('Débloquer'),
                      onPressed: () {
                        DiapasonApi().clearBlackListedMember(memberNotifier, blackListedUid);
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: AlertCancelationText('Annuler'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  // USER

  void showUserOptions(BuildContext context, Member member, String blackId, Function callBackOne, Function callBackTwo) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          if(!member.blackList.contains(blackId)) {
            return SafeArea(
              child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: kDrawerBackgroundColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AlertSqueezableOption(callback: callBackOne, iconData: kReportContentIconData, message: 'Signaler cet utilisateur', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                          Divider(
                            color: kDrawerDividerColor,
                            thickness: 1.5,
                          ),
                          AlertSqueezableOption(callback: callBackTwo, iconData: kBanUserContentIconData, message: 'Bloquer cet utilisateur', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    AlertCancelButton(),
                  ]),
            );
          } else {
            return SafeArea(
              child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: kDrawerBackgroundColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AlertSqueezableOption(callback: callBackOne, iconData: kReportContentIconData, message: 'Signaler cet utilisateur', pad: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 20.0, right: 15.0),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    AlertCancelButton(),
                  ]),
            );
          }
        });
  }

  // VISITOR

  Future<void> witnessVisitorUpgradeToMembership(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 4), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: AlertRegularText(
                'L\'utilisateur est maintenant membre de Diapason. Il doit se déconnecter / reconnecter pour que le changement devienne effectif',
              ),
            ),
          );
        }
    ).then((value){
      if(_timer.isActive) {
        _timer.cancel();
      }
    });
  }


  // EVENTS

  void showEventOptions(BuildContext context, Member member, Event event, Function callBackOne, Function callBackTwo, Function callBackThree, Function callBackFour) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  (member.uid == event.referent || member.superAdmin == true)
                      ? Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AlertSqueezableOption(
                            callback: callBackOne,
                            iconData: kUpdateObjectIconData,
                            message: 'Modifier l\'événement',
                            pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(
                            callback: callBackTwo,
                            iconData: kDeleteObjectIconData,
                            message: 'Supprimer l\'événement',
                            pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),
                        ),
                      ],
                    ),
                  )
                      : Container(width: 0.0, height: 0.0),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackThree, iconData: kReportContentIconData, message: 'Signaler le contenu', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackFour, iconData: kBanUserContentIconData, message: 'Bloquer l\'auteur de ce contenu', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AlertCancelButton(),
                ]),
          );
        });
  }

  Future<void> witnessEventAction(BuildContext context, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            content: AlertRegularText(
              message,
            ),
          );
        }
    ).then((value){
      if(_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  // STORIES

  void showStoriesOptions(BuildContext context, Member member, Story story, Function callBackOne, Function callBackTwo, Function callBackThree, Function callBackFour) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  (member.superAdmin == true)
                      ? Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackOne, iconData: kUpdateObjectIconData, message: 'Modifier la story', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackTwo, iconData: kDeleteObjectIconData, message: 'Supprimer la story', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0)),
                      ],
                    ),
                  )
                      : Container(width: 0.0, height: 0.0),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackThree, iconData: kReportContentIconData, message: 'Signaler le contenu', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackFour, iconData: kBanUserContentIconData, message: 'Bloquer l\'auteur de ce contenu', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AlertCancelButton(),
                ]),
          );
        });
  }

  // ACTIVITIES

  void showActivitiesOptions(BuildContext context, Member member, Activity activity, Function callBackOne, Function callBackTwo, Function callBackThree, Function callBackFour) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  (member.uid == activity.leader || member.superAdmin == true)
                      ? Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackOne, iconData: kUpdateObjectIconData, message: 'Modifier l\'activité', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackTwo, iconData: kDeleteObjectIconData, message: 'Supprimer l\'activité', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                      ],
                    ),
                  )
                      : Container(width: 0.0, height: 0.0),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackThree, iconData: kReportContentIconData, message: 'Signaler le contenu', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackFour, iconData: kBanUserContentIconData, message: 'Bloquer l\'auteur de ce contenu', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AlertCancelButton(),
                ]),
          );
        });
  }


  // ITEMS

  void showItemOptions(BuildContext context, Member member, Item item, Function callBackOne, Function callBackTwo, Function callBackThree, Function callBackFour) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  // Creation and modification allowed to executives, board and item owner
                  (member.uid == item.owner || member.superAdmin == true)
                      ? Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackOne, iconData: kUpdateObjectIconData, message: 'Modifier l\'objet', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackTwo, iconData: kDeleteObjectIconData, message: 'Supprimer l\'objet', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0)),
                      ],
                    ),
                  )
                      : Container(width: 0.0, height: 0.0),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: kDrawerBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AlertSqueezableOption(callback: callBackThree, iconData: kReportContentIconData, message: 'Signaler le contenu', pad: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 20.0, right: 15.0),),
                        Divider(
                          color: kDrawerDividerColor,
                          thickness: 1.5,
                        ),
                        AlertSqueezableOption(callback: callBackFour, iconData: kBanUserContentIconData, message: 'Bloquer l\'auteur de ce contenu', pad: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 20.0, right: 15.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AlertCancelButton(),
                ]),
          );
        });
  }

  // CLAIMS

  Future<void> witnessClaimCreation(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 3), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: kDrawerBackgroundColor,
            content: AlertRegularText(
                'Votre demande a été prise en compte et sera traitée dans les 24 heures',
            ),
          );
        }
    ).then((value){
      if(_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  void updateClaimStatusAlert(BuildContext context, Function callBackOne, Function callBackTwo) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: kDrawerBackgroundColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0, top: 20.0, left: 20.0, right: 20.0),
                      child: InkWell(
                        onTap: callBackOne,
                        child: AlertChoiceRegularText(text: '🟢  Demande traitée : Contenu supprimé'),
                      ),
                    ),
                    Divider(
                      color: kDrawerDividerColor,
                      thickness: 1.5,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: InkWell(
                        onTap: callBackTwo,
                        child: AlertChoiceRegularText(text:
                          '🔵  Demande traitée : Contenu conservé'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              AlertCancelButton(),
            ]),
          );
        });
  }
}





