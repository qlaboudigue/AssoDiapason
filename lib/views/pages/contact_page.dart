import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {

  static String route = 'contact_page';
  final String _youtubeUrl = kYoutubeURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Nous contacter'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
              color: kOrangeMainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 15.0),
              child: Center(
                child: Icon(
                  Icons.contact_support_rounded,
                  color: kDrawerDividerColor,
                  size: 25.0,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: SharedRegularTextWidget(
                'Pour toute demande d\'adhésion à l\'association Diapason, vous pouvez contacter notre équipe dont les coordonnées sont indiquées ci-dessous :',
                color: kWhiteColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () async {
                  if (await canLaunch('mailto:$kCoordinatorMail')) {
                    await launch('mailto:$kCoordinatorMail');
                  } else {
                    throw 'Could not launch';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileDetailText('Contactez notre coordinatrice'),
                          SizedBox(height: 5.0),
                          ProfileContactText(kCoordinatorMail),
                        ],
                      ),
                    ),
                    ProfileIcon(iconData: Icons.mail, iconSize: 35.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () async {
                  if (await canLaunch('mailto:$kBoardMail')) {
                    await launch('mailto:$kBoardMail');
                  } else {
                    throw 'Could not launch';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileDetailText('Contactez notre bureau'),
                          SizedBox(height: 5.0),
                          ProfileContactText(kBoardMail),
                        ],
                      ),
                    ),
                    ProfileIcon(iconData: Icons.mail, iconSize: 35.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () async {
                  if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
                    if (await canLaunch(_youtubeUrl)) {
                      final bool _nativeAppLaunchSucceeded = await launch(
                        _youtubeUrl,
                        forceSafariVC: false,
                        universalLinksOnly: true,
                      );
                      if (!_nativeAppLaunchSucceeded) {
                        await launch(_youtubeUrl, forceSafariVC: true);
                      }
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileDetailText('Retrouvez nous sur Youtube'),
                          SizedBox(height: 5.0),
                          ProfileContactText(kYoutubeURL),
                        ],
                      ),
                    ),
                    ProfileIcon(iconData: Icons.slow_motion_video, iconSize: 35.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
