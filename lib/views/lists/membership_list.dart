import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class MembershipList extends StatelessWidget {

  final MemberNotifier memberNotifier;
  final Function membershipAction;

  MembershipList({@required this.memberNotifier, @required this.membershipAction});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: kDrawerDividerColor,
          thickness: 1.0,
        ),
        itemCount: memberNotifier.membersShipList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: membershipAction,
            child: ListTile(
              dense: true,
              title: UserTileNameText('${memberNotifier.membersShipList[index].forename.capitalize()} ${memberNotifier.membersShipList[index].name.capitalize()}'),
              // subtitle: UserTileImplicationText('${memberNotifier.membersShipList[index].implication}'),
            ),
          );
        }
    );
  }
}