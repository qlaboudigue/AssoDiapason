import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/controllers/upload_profile_controller.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/views/pages/current_member_items_page.dart';
import 'package:diapason/views/tiles/profile_contact_information_tile.dart';
import 'package:diapason/views/pages/black_list_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';
import 'admin_control_panel_page.dart';

class ProfilePage extends StatefulWidget {
  static String route = 'profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
              color: kOrangeMainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Mon profil'),
        actions: <Widget>[
          Consumer<MemberNotifier>(
            builder: (context, memberNotifier, child) {
              if (memberNotifier.currentMember.membership == true) {
                return IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadProfileController()));
                  },
                  icon: Icon(
                    Icons.mode_edit,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Consumer<MemberNotifier>(
                        builder: (context, memberNotifier, child) {
                      if (memberNotifier.currentMember != null) {
                        if(memberNotifier.currentMember.admin == true) {
                          return Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0),
                                child: CachedNetworkImage(
                                  imageUrl: memberNotifier.currentMember.imageUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      ProfileImage(
                                        size: 40.0,
                                        urlString: memberNotifier.currentMember.imageUrl,
                                        color: kOrangeAccentColor,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminControlPanelPage()));
                                        },
                                      ),
                                  placeholder: (context, url) =>
                                      MediumImagePlaceholderWidget(),
                                  // ActivityImagePlaceholderWidget(),
                                  errorWidget: (context, url, error) =>
                                      ProfilePageImageErrorWidget(),
                                  // ActivityBackgroundDefaultImage(),
                                )
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminControlPanelPage()));
                                    },
                                    child: AdminBadge(),
                                  )),
                            ],
                          );
                        } else {
                          return CachedNetworkImage(
                            imageUrl: memberNotifier.currentMember.imageUrl,
                            imageBuilder: (context, imageProvider) =>
                                ProfileImage(
                                  size: 40.0,
                                  urlString: memberNotifier.currentMember.imageUrl,
                                  color: kOrangeAccentColor,
                                  onTap: () {},
                                ),
                            placeholder: (context, url) =>
                                MediumImagePlaceholderWidget(),
                            // ActivityImagePlaceholderWidget(),
                            errorWidget: (context, url, error) =>
                                ProfilePageImageErrorWidget(),
                            // ActivityBackgroundDefaultImage(),
                          );
                        }
                      } else {
                        return EmptyContainer();
                      }
                    }),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Consumer<MemberNotifier>(
                              builder: (context, memberNotifier, child) {
                                if(memberNotifier.currentMember != null) {
                                  return ProfileNameText(
                                      '${memberNotifier.currentMember.forename.capitalize()} ${memberNotifier.currentMember.name.capitalize()}');
                                } else {
                                  return ProfileNameText('Visiteur Diapason');
                                }
                              }),
                          SizedBox(height: 5.0),
                          Consumer<MemberNotifier>(
                              builder: (context, memberNotifier, child) {
                                if(memberNotifier.currentMember != null) {
                                  return SubTitleText(
                                      '${memberNotifier.currentMember.implication}');
                                } else {
                                  return ProfileNameText('🔍 Visiteur');
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget(
                  'Mes informations personnelles',
                  fontSize: 18.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: kDrawerDividerColor,
                  ),
                  child: Consumer<MemberNotifier>(
                    builder: (context, memberNotifier, child) {
                      if (memberNotifier.currentMember != null) {
                        return ProfileContactInformationTile(
                          phone: memberNotifier.currentMember.phone,
                          mail: memberNotifier.currentMember.mail,
                          address: memberNotifier.currentMember.address,
                        );
                      } else {
                        return ProfileContactInformationTile(
                          phone: 'Information non disponible',
                          mail: 'Information non disponible',
                          address: 'Information non disponible',
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget(
                  'Ma black list',
                  fontSize: 18.0,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: kDrawerDividerColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: Consumer<MemberNotifier>(
                    builder: (context, memberNotifier, child) {
                      if (memberNotifier.currentMember.blackList != null) {
                        if (memberNotifier.currentMember.blackList.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return BlackListPage();
                              }));
                            },
                            child: MemberBlackListSummary(
                                text:
                                    '${memberNotifier.currentMember.blackList.length} membre(s) bloqué(s) actuellement'),
                          );
                        } else {
                          return MemberBlackListSummary(
                              text:
                                  '${memberNotifier.currentMember.blackList.length} membre(s) bloqué(s) actuellement');
                        }
                      } else {
                        return MemberBlackListSummary(
                            text: 'Information non disponible');
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: SharedSubTextWidget(
                  'Mon matériel',
                  fontSize: 18.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    color: kDrawerDividerColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),

                  child: Consumer<MemberNotifier>(
                    builder: (context, memberNotifier, child) {
                      if (memberNotifier.currentMember.items != null) {
                        if (memberNotifier.currentMember.items.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CurrentMemberItemsPage();
                              }));
                            },
                            child: MemberItemsSummary(
                                text:
                                    '${memberNotifier.currentMember.items.length} objet(s) partagé(s) actuellement'),
                          );
                        } else {
                          return MemberItemsSummary(
                            text: '0 objet(s) partagé(s) actuellement',
                          );
                        }
                      } else {
                        return MemberItemsSummary(
                            text: 'Information non disponible');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


