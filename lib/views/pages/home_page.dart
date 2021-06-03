import 'package:diapason/models/member.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 35.0,
            color: kOrangeMainColor,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        elevation: 10.0,
        centerTitle: true, // android override
        title: Image.asset(
          kHomeLogoPicture,
          fit: BoxFit.contain,
          height: 40.0,
        ),
      ),
      drawer: DrawerGeneral(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Image.asset(kAboutLogoPicture, height: 95.0),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<MemberNotifier>(
                                        builder:
                                            (context, memberNotifier, child) {
                                          if (memberNotifier.membersAdminList !=
                                                  null &&
                                              memberNotifier.membersAdminList
                                                  .isNotEmpty) {
                                            return NumberText(
                                              memberNotifier
                                                  .membersAdminList.length
                                                  .toString(),
                                              fontSize: 22.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        kAdminsNumberIconData,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<MemberNotifier>(
                                        builder:
                                            (context, memberNotifier, child) {
                                          if (memberNotifier.membersShipList !=
                                                  null &&
                                              memberNotifier
                                                  .membersShipList.isNotEmpty) {
                                            return NumberText(
                                              memberNotifier
                                                  .membersShipList.length
                                                  .toString(),
                                              fontSize: 22.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        kMembersNumberIconData,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<EventNotifier>(
                                        builder:
                                            (context, eventNotifier, child) {
                                          if (eventNotifier.eventList != null &&
                                              eventNotifier
                                                  .eventList.isNotEmpty) {
                                            return NumberText(
                                              eventNotifier.eventList.length
                                                  .toString(),
                                              fontSize: 22.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.local_activity,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<StoryNotifier>(
                                        builder:
                                            (context, storyNotifier, child) {
                                          if (storyNotifier.storyList != null &&
                                              storyNotifier
                                                  .storyList.isNotEmpty) {
                                            return NumberText(
                                              storyNotifier.storyList.length
                                                  .toString(),
                                              fontSize: 22.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.graphic_eq_rounded,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<ActivityNotifier>(
                                        builder:
                                            (context, activityNotifier, child) {
                                          if (activityNotifier.activityList !=
                                                  null &&
                                              activityNotifier
                                                  .activityList.isNotEmpty) {
                                            return NumberText(
                                              activityNotifier
                                                  .activityList.length
                                                  .toString(),
                                              fontSize: 22.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.all_inclusive_sharp,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Consumer<ItemNotifier>(
                                        builder:
                                            (context, itemNotifier, child) {
                                          if (itemNotifier.itemsList !=
                                              null &&
                                              itemNotifier
                                                  .itemsList.isNotEmpty) {
                                            return NumberText(
                                              itemNotifier
                                                  .itemsList.length
                                                  .toString(),
                                              fontSize: 25.0,
                                            );
                                          } else {
                                            return NumberText('0');
                                          }
                                        },
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.build,
                                        size: 30.0,
                                        color: kSubTextColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AboutRegularText(kMainDescription),
                    AboutRegularText(kMainSpot),
                    AboutRegularText(kMainMoto),
                    AboutRegularText(kMainContact),
                  ],
                ),
              ),
              Consumer<MemberNotifier>(
                  builder: (context, memberNotifier, child) {
                if (memberNotifier != null) {
                  if (memberNotifier.membersAdminList != null &&
                      memberNotifier.membersAdminList.isNotEmpty) {
                    List<Member> _adminList = [];
                    for (Member member in memberNotifier.membersAdminList) {
                      if (member.forename != 'Utilisateur' && member.name != 'Diapason') {
                        _adminList.add(member);
                      }
                    }
                    return Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 15,
                        // children: memberNotifier.membersAdminList
                          children: _adminList
                            .map((member) => Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return UserPage(member);
                                      }));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            // height: 110.0,
                                            padding: EdgeInsets.all(
                                                2.0), // for border visibility
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: kOrangeMainColor,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: (member.imageUrl !=
                                                                '' &&
                                                            member.imageUrl !=
                                                                null)
                                                        ? Image.network(
                                                                member.imageUrl)
                                                            .image
                                                        : kProfileDefaultImage),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        AboutSubText(
                                            text:
                                                '${member.forename.capitalize()}'),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  } else {
                    return EmptyContainer();
                  }
                } else {
                  return EmptyContainer();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
