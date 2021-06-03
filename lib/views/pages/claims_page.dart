import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/views/my_widgets/app_bar_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ClaimsPage extends StatefulWidget {
  @override
  _ClaimsPageState createState() => _ClaimsPageState();
}

class _ClaimsPageState extends State<ClaimsPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ClaimNotifier claimNotifier =
        Provider.of<ClaimNotifier>(context, listen: false);
    DiapasonApi().getClaims(claimNotifier);
    super.initState();
  }

  Future<void> _getClaimList() async {
    ClaimNotifier claimNotifier = Provider.of<ClaimNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getClaims(claimNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBarBackgroundColor,
          elevation: 10.0,
          centerTitle: true, // android override
          title: AppBarTextWidget(text: 'Contenu signalé'),
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
                  child: FaIcon(
                    FontAwesomeIcons.angry,
                    color: kDrawerDividerColor,
                    size: 25.0,
                  ),
                ))
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _getClaimList,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<ClaimNotifier>(
              builder: (context, claimNotifier, child) {
                if (claimNotifier.claimList != null &&
                    claimNotifier.claimList.isNotEmpty) {
                  return ClaimList(claimNotifier: claimNotifier);
                } else {
                  return EmptyClaimsContainer();
                }
              },
            ),
          ),
        )
        );
  }
}


