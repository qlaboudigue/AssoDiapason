import 'package:diapason/models/member.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class SubDirectoryList extends StatelessWidget {

  final List<Member> membersList;

  SubDirectoryList({@required this.membersList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: kDrawerDividerColor,
          thickness: 1.0,
        ),
        itemCount: membersList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            dense: true,
            contentPadding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
            leading: ProfileImage(
                size: 22.0,
                urlString: membersList[index].imageUrl,
                color: kOrangeMainColor,
                onTap: () {}),
            title: UserTileNameText(
                '${membersList[index].forename.capitalize()} ${membersList[index].name.capitalize()}'),
            // subtitle: UserTileImplicationText(activeMembers[index].implication),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: kOrangeMainColor,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return UserPage(
                        membersList[index]);
                  }));
            },
          );
        });
  }
}
