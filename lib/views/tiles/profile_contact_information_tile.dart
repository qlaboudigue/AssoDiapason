import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';

class ProfileContactInformationTile extends StatelessWidget {

  final String phone;
  final String mail;
  final String address;

  ProfileContactInformationTile({
    @required this.phone,
    @required this.mail,
    @required this.address,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
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
          SizedBox(height: 15.0,),
          Row(
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
          SizedBox(height: 15.0,),
          Row(
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
        ],
      ),
    );
  }
}
