import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CurrentMemberItemsPage extends StatefulWidget {

  @override
  _CurrentMemberItemsPageState createState() => _CurrentMemberItemsPageState();

}

class _CurrentMemberItemsPageState extends State<CurrentMemberItemsPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    DiapasonApi().getCurrentMemberItemsList(memberNotifier);
  }

  Future<void> _getCurrentMemberItemsList() async {
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getCurrentMemberItemsList(memberNotifier);
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
          title: AppBarTextWidget(text: 'Mon matériel'),
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
                    FontAwesomeIcons.tools,
                    color: kDrawerDividerColor,
                    size: 25.0,
                  ),
                ))
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _getCurrentMemberItemsList,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<MemberNotifier>(
              builder: (context, memberNotifier, child) {
                if (memberNotifier.currentMemberItems != null && memberNotifier.currentMemberItems.isNotEmpty) {
                  ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
                  return ItemsList(itemsList: memberNotifier.currentMemberItems, itemNotifier: itemNotifier);
                } else {
                  return EmptyItemsListContainer();
                }
              },
            ),
          ),
        )
    );
  }
}


