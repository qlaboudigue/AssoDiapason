import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/controllers/upload_activity_controller.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  void _updateActivity() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UploadActivityController())); // Modify activity
  }

  void _deleteActivity(ActivityNotifier activityNotifier) {
    Navigator.pop(context);
    DiapasonApi().deleteActivity(activityNotifier); // Delete activity
    Navigator.pop(context);
  }

  void _flagActivity(ActivityNotifier activityNotifier) {
    Navigator.pop(context);
    ClaimNotifier claimNotifier =
    Provider.of<ClaimNotifier>(context, listen: false);
    Claim _currentClaim = Claim();
    _currentClaim.content = activityNotifier.currentActivity.name;
    _currentClaim.type = _currentClaim.claimTypeList[3];
    claimNotifier.currentClaim = _currentClaim;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UploadClaimController()));
  }

  void _blackListAuthor(MemberNotifier memberNotifier, ActivityNotifier activityNotifier) {
    Navigator.pop(context);
    Navigator.pop(context);
    DiapasonApi().blackListMember(
        memberNotifier, activityNotifier.currentActivity.leader);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBarBackgroundColor,
          elevation: 10.0,
          centerTitle: true, // android override
          title: Consumer<ActivityNotifier>(
            builder: (context, activityNotifier, child) {
              if(activityNotifier.currentActivity != null) {
                return AppBarTextWidget(text: activityNotifier.currentActivity.name);
              } else {
                return AppBarTextWidget(text: 'Activité pratiquée');
              }
            },
          ),
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
            IconButton(
              onPressed: () {
                ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context, listen: false);
                MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
                AlertHelper().showActivitiesOptions(
                  context,
                  memberNotifier.currentMember,
                  activityNotifier.currentActivity,
                  () => _updateActivity(),
                  () => _deleteActivity(activityNotifier),
                  () => _flagActivity(activityNotifier),
                  () => _blackListAuthor(memberNotifier, activityNotifier),
                );
              },
              icon: Icon(
                kPendingIcon,
                size: 33.0,
                color: kOrangeMainColor,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<ActivityNotifier>(
                      builder: (context, activityNotifier, child) {
                    if (activityNotifier.currentActivity.backgroundImageUrl != null && activityNotifier.currentActivity.backgroundImageUrl != '') {
                      return CachedNetworkImage(
                        imageUrl: activityNotifier.currentActivity.backgroundImageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: (MediaQuery.of(context).size.width * 9) / 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                        ),
                        placeholder: (context, url) =>
                            BackgroundImagePlaceholderWidget(),
                        errorWidget: (context, url, error) =>
                            ActivityBackgroundDefaultImage(),
                      );
                    } else {
                      return ActivityBackgroundDefaultImage();
                    }
                  }),
                  Consumer<ActivityNotifier>(
                      builder: (context, activityNotifier, child) {
                    if (activityNotifier.activityLeaders != null &&
                        activityNotifier.activityLeaders.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 15.0,
                                bottom: 8.0),
                            child: AboutSubText(text: '🌟 Référent(s) Diapason'),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Divider(
                              color: kDrawerDividerColor,
                              thickness: 1.0,
                            ),
                            itemCount: activityNotifier.activityLeaders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: activityNotifier
                                      .activityLeaders[index].imageUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kOrangeMainColor,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 45.0,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      MediumImagePlaceholderWidget(),
                                  errorWidget: (context, url, error) =>
                                      ProfileDefaultImageWidget(),
                                ),
                                // ProfileImage(urlString: activityNotifier.activityLeaders[index].imageUrl, size: 25.0, onTap: (){}, color: kOrangeAccentColor,),
                                title: UserTileNameText(
                                    '${activityNotifier.activityLeaders[index].forename.capitalize()} ${activityNotifier.activityLeaders[index].name.capitalize()}'),
                                subtitle: SharedSubTextWidget(
                                    activityNotifier.activityLeaders[index]
                                        .getValuation()),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: kOrangeMainColor,
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UserPage(activityNotifier
                                        .activityLeaders[index]);
                                  }));
                                },
                              );
                            },
                          )
                        ],
                      );
                    } else {
                      return EmptyContainer();
                    }
                  }),
                ]),
          ),
        ));
  }
}
