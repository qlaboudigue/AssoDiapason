import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class DirectoryPage extends StatefulWidget {
  // String used for routes Navigation through app
  static String route = 'directory_page';

  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {

  // INIT STATE METHOD
  @override
  void initState() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    DiapasonApi().getMembersShip(memberNotifier);
    super.initState();
  }

  // METHODS
  Future<void> _getMembersList() async {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getMembersShip(memberNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Les adhérents'),
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
                  kMembersNumberIconData,
                  color: kDrawerDividerColor,
                  size: 25.0,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getMembersList,
          color: kOrangeMainColor,
          backgroundColor: kDrawerBackgroundColor,
          child: Consumer<MemberNotifier>(
            builder: (context, memberNotifier, child) {
              if (memberNotifier.currentMember.membership == true) {
                List<Member> activeMembers = [];
                List<Member> punctualMembers = [];
                List<Member> honoredMembers = [];
                for (Member member in memberNotifier.membersShipList) {
                  if(member.forename != 'Utilisateur' && member.name != 'Diapason') {
                    if (member.implication == member.memberImplicationList[0]) {
                      activeMembers.add(member);
                    }
                    if (member.implication == member.memberImplicationList[1]) {
                      punctualMembers.add(member);
                    }
                    if (member.implication == member.memberImplicationList[2]) {
                      honoredMembers.add(member);
                    }
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (activeMembers.isNotEmpty)
                      ? Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                        child: RegulationRegularText(
                          memberNotifier.currentMember.memberImplicationList[0],
                          fontSize: 18.0,
                          color: kSubTextColor,
                        ),
                      )
                      : Container(height: 0.0, width: 0.0),
                      SubDirectoryList(membersList: activeMembers),
                      (punctualMembers.isNotEmpty)
                      ? Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                        child: RegulationRegularText(
                          memberNotifier.currentMember.memberImplicationList[1],
                          fontSize: 18.0,
                          color: kSubTextColor,
                        ),
                      )
                      : EmptyContainer(),
                      SubDirectoryList(membersList: punctualMembers),
                      (honoredMembers.isNotEmpty)
                      ? Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                        child: RegulationRegularText(
                          memberNotifier.currentMember.memberImplicationList[2],
                          fontSize: 18.0,
                          color: kSubTextColor,
                        ),
                      )
                      : Container(height: 0.0),
                      SubDirectoryList(membersList: honoredMembers),
                      SizedBox(height: 15.0),
                    ],
                  ),
                );
              } else {
                return EmptyMembershipContainer(
                  message:
                  'Vous devez être adhérent.e pour accéder à ces informations',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

