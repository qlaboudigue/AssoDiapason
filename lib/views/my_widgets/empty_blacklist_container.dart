import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EmptyBlackListContainer extends StatelessWidget {
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
            margin: EdgeInsets.only(bottom: 15.0),
            width: 110.0,
            height: 110.0,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(15.0)),
            child: Icon(
              Icons.local_florist,
              size: 70.0,
              color: kOrangeDeepColor,
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0),
                child: RegulationRegularText(
                  'Vous n\'avez actuellement bloqué aucun membre Diapason',
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