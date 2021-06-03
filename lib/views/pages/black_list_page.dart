import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class BlackListPage extends StatefulWidget {

  static String route = 'black_list_page';

  @override
  _BlackListPageState createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlackListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    DiapasonApi().getCurrentUserBlackListedMembers(memberNotifier);
  }

  Future<void> _getBlackList() async {
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    setState(() {
      if(memberNotifier != null) {
        DiapasonApi().getCurrentUserBlackListedMembers(memberNotifier);
      } else {
        return null;
      }
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
          title: AppBarTextWidget(text: 'Membres bloqués'),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25.0,
                color: kOrangeMainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _getBlackList,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<MemberNotifier>(
              builder: (context, memberNotifier, child) {
                if(memberNotifier != null) {
                  if (memberNotifier.membersBlackList != null && memberNotifier.membersBlackList.isNotEmpty) {
                    return CurrentUserBlackList(memberNotifier: memberNotifier);
                  } else {
                    return EmptyBlackListContainer();
                  }
                } else {
                  return EmptyBlackListContainer();
                }
              },
            ),
          ),
        )
    );
  }
}



