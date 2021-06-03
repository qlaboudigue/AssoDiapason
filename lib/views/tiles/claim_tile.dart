import 'package:diapason/models/claim.dart';
import 'package:diapason/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ClaimTile extends StatefulWidget {

  final Claim claim;
  ClaimTile({@required this.claim});

  @override
  _ClaimTileState createState() => _ClaimTileState();
}

class _ClaimTileState extends State<ClaimTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
      height: 125.0,
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: kTileBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // color: Colors.purple,
            padding: EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  // color: Colors.blue,
                  child: Row(
                    children: <Widget>[
                      claimSeverity(),
                      EventTileTitleText(' : ${widget.claim.type}', fontSize: 18.0,),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.move_to_inbox, color: kSubTextColor, size: 20.0,),
                      SizedBox(width: 5.0),
                      EventTileDetailText(DateHelper().eventDateLine(widget.claim.date)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: ClaimTileText('${widget.claim.content} : ${widget.claim.description}', fontSize: 18.0,)),
          EventTileDetailText(widget.claim.status),
        ],
      ),
    );
  }

  Widget claimSeverity() {
    switch (widget.claim.severity) {
      case 1:
        {
          return NumberText(
            widget.claim.severity.toString(),
            color: kWhiteColor,
            fontSize: 25.0,
          );
        }
        break;
      case 2:
        {
          return NumberText(
            widget.claim.severity.toString(),
            color: kOrangeMainColor,
            fontSize: 25.0,
          );
        }
        break;
      case 3:
        {
          return NumberText(
            widget.claim.severity.toString(),
            color: kOrangeDeepColor,
            fontSize: 25.0,
          );
        }
        break;
      case 4:
        {
          return NumberText(
            widget.claim.severity.toString(),
            color: kRedAccentColor,
            fontSize: 25.0,
          );
        }
        break;
      default:
        {
          return NumberText(
            widget.claim.severity.toString(),
            color: kWhiteColor,
            fontSize: 25.0,
          );
        }
        break;
    }
  }



}
