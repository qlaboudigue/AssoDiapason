import 'package:diapason/util/location_helper.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserContactInformationTile extends StatelessWidget {

  final String phone;
  final String mail;
  final String address;

  UserContactInformationTile({
    @required this.phone,
    @required this.mail,
    @required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () async {
              String telephoneUrl = 'tel:$phone';
              if (await canLaunch(telephoneUrl)) {
                await launch(telephoneUrl);
              } else {
                throw 'Can\'t phone that number.';
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProfileDetailText('Téléphone'),
                      SizedBox(height: 5.0),
                      ProfileContactText(phone),
                    ],
                  ),
                ),
                ProfileIcon(iconData: Icons.phone, iconSize: 35.0),
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          InkWell(
            onTap: () async {
              if (await canLaunch('mailto:$mail')) {
                await launch('mailto:$mail');
              } else {
                throw 'Could not launch';
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ProfileDetailText('Adresse mail'),
                    SizedBox(height: 5.0),
                    ProfileContactText(mail),
                  ],
                ),
                ProfileIcon(iconData: Icons.mail, iconSize: 35.0),
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          InkWell(
            onTap: () async {
              var latitude;
              var longitude;
              latitude = await LocationHelper()
                  .getGeoFromAddress(address)
                  .then((value) => latitude = value.latitude);
              longitude = await LocationHelper()
                  .getGeoFromAddress(address)
                  .then((value) => longitude = value.longitude);
              final String googleMapsUrl =
                  "comgooglemaps://?center=$latitude,$longitude";
              final String appleMapsUrl =
                  "https://maps.apple.com/?q=$latitude,$longitude";
              if (await canLaunch(googleMapsUrl)) {
                await launch(googleMapsUrl);
              }
              if (await canLaunch(appleMapsUrl)) {
                await launch(appleMapsUrl, forceSafariVC: false);
              } else {
                throw "Couldn't launch URL";
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProfileDetailText('Adresse'),
                      SizedBox(height: 5.0),
                      ProfileContactText(address),
                    ],
                  ),
                ),
                ProfileIcon(iconData: Icons.location_on, iconSize: 35.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
