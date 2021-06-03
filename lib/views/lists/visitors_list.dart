import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/visitor_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VisitorsList extends StatelessWidget {

  final VisitorNotifier visitorNotifier;

  VisitorsList({@required this.visitorNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: kDrawerDividerColor,
            thickness: 1.0,
            height: 1, // Way to kill padding
          ),
          itemCount: visitorNotifier.visitorsList.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
                child: ListTile(
                  dense: true,
                  title: VisitorTileTitleText(visitorNotifier.visitorsList[index].mail),
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Adhérent',
                  color: kOrangeDeepColor,
                  icon: Icons.upload_rounded,
                  onTap: () {
                    DiapasonApi().upgradeVisitor(visitorNotifier, visitorNotifier.visitorsList[index]);
                    AlertHelper().witnessVisitorUpgradeToMembership(context);
                  },
                ),
              ],
            );
          }),
    );
  }
}