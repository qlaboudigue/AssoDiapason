import 'package:diapason/views/pages/claims_page.dart';
import 'package:diapason/views/pages/visitors_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class AdminControlPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Administrateur'),
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
                  Icons.security,
                  color: kDrawerDividerColor,
                  size: 28.0,
                ),
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: GenericButton(
                      label: 'Contenu indésirable',
                      buttonColor: kOrangeAccentColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClaimsPage()));
                      }
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: GenericButton(
                      label: 'Liste des utilisateurs',
                      buttonColor: kOrangeAccentColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorsPage()));
                      }
                  ),
                ),
          ],
        ),
      )),
    );
  }
}
