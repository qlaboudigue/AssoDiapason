import 'package:diapason/models/member.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UserTile extends StatelessWidget {

  final Member member;
  UserTile(this.member);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: UserTileNameText('${member.forename.capitalize()} ${member.name.capitalize()}'),
      leading: FaIcon(FontAwesomeIcons.brain, size: menuIconSize, color: kOrangeMainColor,),
      // leading: ProfileImage(size: 25.0, urlString: member.imageUrl, color: kWhiteColor, onTap: () {}),
      trailing: Icon(Icons.arrow_forward_ios, color: kOrangeMainColor,),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserPage(member);
        }));
      },
    );
  }
}