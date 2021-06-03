import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class CurrentUserBlackList extends StatelessWidget {

  final MemberNotifier memberNotifier;

  CurrentUserBlackList({@required this.memberNotifier});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: kDrawerDividerColor,
        thickness: 1.0,
      ),
      itemCount: memberNotifier.membersBlackList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: UserTileNameText(
              '${memberNotifier.membersBlackList[index].forename} ${memberNotifier.membersBlackList[index].name}'),
          subtitle: SharedSubTextWidget(
              memberNotifier.membersBlackList[index].implication),
          trailing: InkWell(
            onTap: () {
              AlertHelper().clearBlackListedMember(context, memberNotifier, memberNotifier.membersBlackList[index].uid);
            },
            child: UserTileNameText(
              'Débloquer',
              color: kOrangeMainColor,
            ),
          ),
        );
      },
    );
  }
}
