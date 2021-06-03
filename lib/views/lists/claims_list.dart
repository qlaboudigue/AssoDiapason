import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/views/tiles/claim_tile.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ClaimList extends StatelessWidget {

  final ClaimNotifier claimNotifier;

  ClaimList({@required this.claimNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: ListView.builder(
          itemCount: claimNotifier.claimList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                AlertHelper().updateClaimStatusAlert(context, () {
                  String _statusUpdate = claimNotifier.claimList[index].claimStatusList[1];
                  DiapasonApi().updateClaimStatus(claimNotifier, claimNotifier.claimList[index], _statusUpdate);
                  Navigator.pop(context);
                }, () {
                  String _statusUpdate = claimNotifier.claimList[index].claimStatusList[2];
                  DiapasonApi().updateClaimStatus(claimNotifier, claimNotifier.claimList[index], _statusUpdate);
                  Navigator.pop(context);
                }
                );
              },
              child: Container(
                child: ClaimTile(claim: claimNotifier.claimList[index]),
              ),
            );
          }),
    );
  }
}