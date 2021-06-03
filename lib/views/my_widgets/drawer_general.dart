import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/login_controller.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/user_notifier.dart';
import 'package:diapason/views/my_widgets/drawer_item.dart';
import 'package:diapason/views/pages/about_page.dart';
import 'package:diapason/views/pages/contact_page.dart';
import 'package:diapason/views/pages/convention_page.dart';
import 'package:diapason/views/pages/directory_page.dart';
import 'package:diapason/views/pages/data_policy_page.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class DrawerGeneral extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Theme(
          data: Theme.of(context).copyWith(
          canvasColor: kDrawerBackgroundColor,
        ),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Consumer<MemberNotifier>(
                          builder: (context, memberNotifier, child) {
                            if(memberNotifier.currentMember != null) {
                              return CachedNetworkImage(
                                imageUrl: memberNotifier.currentMember.imageUrl,
                                imageBuilder: (context, imageProvider) => ProfileImage(
                                  size: 30.0,
                                  urlString: memberNotifier.currentMember.imageUrl,
                                  color: kOrangeAccentColor,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                  },
                                ),
                                placeholder: (context, url) =>
                                    MediumImagePlaceholderWidget(),
                                    // ActivityImagePlaceholderWidget(),
                                errorWidget: (context, url, error) =>
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                      },
                                        child: DrawerProfileImageErrorWidget()),
                                    // ActivityBackgroundDefaultImage(),
                              );
                            } else {
                              return EmptyContainer();
                            }
                          },
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Consumer<MemberNotifier>(
                          builder: (context, memberNotifier, child) {
                            if(memberNotifier.currentMember != null) {
                              return Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      DrawerMemberText('${memberNotifier.currentMember.forename.capitalize()} ${memberNotifier.currentMember.name.capitalize()}'),
                                      SizedBox(height: 10.0),
                                      DrawerSubText(
                                        '${memberNotifier.currentMember.implication}',
                                        color: kSubTextColor,
                                      ),
                                    ],
                                  ));
                            } else {
                              return Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      DrawerMemberText('Utilisateur Diapason'),
                                      SizedBox(height: 10.0),
                                      DrawerSubText(
                                        'Visiteur',
                                        color: kSubTextColor,
                                      ),
                                    ],
                                  ));
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginController()),
                                    (route) => false);
                            UserNotifier authNotifier = Provider.of<UserNotifier>(context, listen: false);
                            DiapasonApi().signOut(authNotifier);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.exit_to_app, color: kOrangeAccentColor, size: 35.0,),
                            SizedBox(width: 15.0),
                            DrawerSubText(
                              'Se déconnecter',
                              color: kWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Divider(
              color: kDrawerDividerColor,
              thickness: 1.5,
            ),
            DrawerItem(
              drawerText: 'À propos',
              iconData: aboutIcon,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AboutPage.route);
              },
            ),
            DrawerItem(
              drawerText: 'Adhérents Diapason',
              iconData: membersIcon,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, DirectoryPage.route);
              },
            ),
            Divider(
              color: kDrawerDividerColor,
              thickness: 1.5,
            ),
            DrawerItem(
              drawerText: 'Nous contacter',
              iconData: contactIcon,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, ContactPage.route);
              },
            ),
            DrawerItem(
              drawerText: 'Conditions d\'utilisation',
              iconData: charteIcon,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, ConventionPage.route);
              },
            ),
            DrawerItem(
              drawerText: 'Politique de confidentialité',
              iconData: privacyIcon,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, PrivacyPolicyPage.route);
              },
            ),
            DrawerItem(
              drawerText: 'Signaler un contenu',
              iconData: reportIcon,
              onTap: () {
                ClaimNotifier claimNotifier = Provider.of<ClaimNotifier>(context, listen: false);
                claimNotifier.currentClaim = null;
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadClaimController()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
