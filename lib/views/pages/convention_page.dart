import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ConventionPage extends StatelessWidget {

  static String route = 'convention_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Conditions d\'utilisation'),
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
                  Icons.description,
                  color: kDrawerDividerColor,
                  size: 25.0,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: ConventionDocument(titleColor: kOrangeMainColor, subTitleColor: kWhiteColor, textColor: kWhiteColor),
        ),
      ),
    );
  }
}
