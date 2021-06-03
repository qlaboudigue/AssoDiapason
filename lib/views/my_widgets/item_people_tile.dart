import 'package:diapason/models/member.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ItemPeopleTile extends StatelessWidget {

  final Member member;
  final FaIcon faIcon;
  final String subtitle;
  ItemPeopleTile({@required this.member, @required this.faIcon, @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 20.0, right: 15.0),
      title: UserTileNameText('${member.forename.capitalize()} ${member.name.capitalize()}'),
      subtitle: SharedSubTextWidget(subtitle),
      leading: faIcon,
      trailing: Icon(Icons.arrow_forward_ios, color: kOrangeMainColor,),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserPage(member);
        }));
      },
    );
  }
}