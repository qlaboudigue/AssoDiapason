import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EmptyMembershipContainer extends StatelessWidget {

  final String message;

  EmptyMembershipContainer({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 110.0,
            height: 110.0,
            margin: EdgeInsets.only(bottom: 15.0),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(15.0)),
            child: Icon(
              Icons.lock,
              size: 60.0,
              color: kOrangeDeepColor,
            ),
          ),
          Container(
            // color: Colors.blue,
              padding:
              EdgeInsets.only(left: 20.0, right: 20.0,),
              child: RegulationRegularText(
                message,
                color: kSubTextColor,
                fontSize: 20.0,
                alignment: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
