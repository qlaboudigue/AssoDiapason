import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EmptyReferentContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15.0, top: 10.0),
            width: 110.0,
            height: 110.0,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(15.0)),
            child: Icon(
              Icons.emoji_people,
              size: 70.0,
              color: kOrangeDeepColor,
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0),
                child: RegulationRegularText(
                  'Il n\'y a actuellement aucun référent sur cette activité',
                  alignment: TextAlign.center,
                  fontSize: 20.0,
                  color: kSubTextColor,
                )),
          ),
        ],
      ),
    );
  }
}
