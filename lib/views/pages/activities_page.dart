import 'dart:async';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_activity_controller.dart';
import 'package:diapason/models/activity.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatefulWidget {

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
    DiapasonApi().getActivities(activityNotifier);
    super.initState();
  }

  Future<void> _getActivities() async {
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getActivities(activityNotifier);
    });
  }

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
              title: AppBarTextWidget(text: 'Activités pratiquées'),
              actions: <Widget>[
                Consumer<MemberNotifier>(
                  builder: (context, memberNotifier, child) {
                    if(memberNotifier.currentMember.admin == true) {
                      return IconButton(
                        onPressed: () {
                          ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
                          activityNotifier.currentActivity = null;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UploadActivityController()));
                        },
                        icon: Icon(
                          Icons.library_add_sharp,
                          size: 33.0,
                          color: kOrangeMainColor,
                        ),
                      );
                    } else {
                      return EmptyContainer();
                    }
                  },
                )
              ],
            ),
      drawer: DrawerGeneral(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getActivities,
          color: kOrangeMainColor,
          backgroundColor: kDrawerBackgroundColor,
          child: Consumer<ActivityNotifier>(
                builder: (context, activityNotifier, child) {
                  if(activityNotifier.activityList.isNotEmpty && activityNotifier.activityList != null) {
                    return Consumer<MemberNotifier>(
                      builder: (context, memberNotifier, child) {
                        List<Activity> _activityList = [];
                        for(Activity activity in activityNotifier.activityList) {
                          if(!memberNotifier.currentMember.blackList.contains(activity.leader)){
                            _activityList.add(activity);
                          }
                        }
                        return ActivitiesList(activityList: _activityList, activityNotifier: activityNotifier);
                      }
                    );
                  } else {
                    return EmptyActivitiesListContainer();
                  }
                },
          )
        ),
      ),
    );
  }
}

