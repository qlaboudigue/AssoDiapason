import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/activity.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/views/pages/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ActivitiesList extends StatelessWidget {

  final List<Activity> activityList;
  final ActivityNotifier activityNotifier;

  ActivitiesList({@required this.activityList, @required this.activityNotifier});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        // shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(
          color: kDrawerDividerColor,
          thickness: 1.0,
        ),
        itemCount: activityList.length,
        itemBuilder: (BuildContext context, int index) {
          EdgeInsets padding;
          if(index == 0) {
            padding = EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0);
          } else if (index == activityList.length - 1) {
            padding = EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0);
          } else {
            padding = EdgeInsets.only(left: 15.0, right: 15.0,);
          }
            return ListTile(
              dense: true,
              contentPadding: padding,
              // contentPadding: (index == 0) ? EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0) : EdgeInsets.only(left: 15.0, right: 15.0,),
              leading: ActivityImage(activity: activityList[index]),
              title: ActivityTileTitleText(activityList[index].name.capitalize()),
              subtitle: ActivityTileSubtitleText(activityList[index].category.capitalize()),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kOrangeMainColor,
              ),
              onTap: () {
                activityNotifier.activityLeaders = [];
                activityNotifier.currentActivity = activityList[index];
                DiapasonApi().getActivityExperts(activityNotifier);
                // DiapasonApi().getActivityLeaders(activityNotifier); // Get Leaders in the current activity
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ActivityPage();
                    }));
              },
            );
        });
  }
}