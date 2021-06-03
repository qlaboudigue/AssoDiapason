import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:flutter/material.dart';
import 'package:diapason/models/member.dart';
import 'package:provider/provider.dart';
import 'package:diapason/util/string_extension.dart';

class UserPage extends StatefulWidget {
  // String used for routes Navigation through app
  static String route = 'user_page';

  final Member member;
  UserPage(this.member);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  void _blackListUser() {
    Navigator.pop(context);
    Navigator.pop(context);
    MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
    DiapasonApi().blackListMember(memberNotifier, widget.member.uid);
  }

  void _flagUser() {
    Navigator.pop(context);
    ClaimNotifier claimNotifier = Provider.of<ClaimNotifier>(context, listen: false);
    Claim _currentClaim = Claim();
    _currentClaim.content = widget.member.name;
    _currentClaim.type = _currentClaim.claimTypeList[0];
    claimNotifier.currentClaim = _currentClaim;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadClaimController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        iconTheme: IconThemeData(
          color: kOrangeMainColor, //change your color here
        ),
        centerTitle: true, // android override
        title: Container(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.member.imageUrl,
                imageBuilder: (context, imageProvider) {
                    return Container(
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
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                },
                placeholder: (context, url) => MediumImagePlaceholderWidget(),
                errorWidget: (context, url, error) => ProfileDefaultImageWidget(),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UserNameText(text:
                      '${widget.member.forename.capitalize()} ${widget.member.name.capitalize()}',
                    ),
                    Container(
                      child: SharedSubTextWidget('${widget.member.implication}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Consumer<MemberNotifier>(
            builder: (context, memberNotifier, child) {
              if (memberNotifier.currentMember.uid != widget.member.uid) {
                return IconButton(
                  onPressed: () {
                    AlertHelper().showUserOptions(
                        context,
                        memberNotifier.currentMember,
                        widget.member.uid,
                        () => _flagUser(),
                        () => _blackListUser()
                    );
                  },
                  icon: Icon(
                    Icons.pending_outlined,
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
        child: Consumer<MemberNotifier>(
          builder: (context, memberNotifier, child) {
            if(memberNotifier.currentMember != null && memberNotifier.currentMember.membership == true) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                      child: SharedSubTextWidget(
                        'Informations de contact',
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: kTileBackgroundColor,
                        ),
                        child: UserContactInformationTile(
                            phone: widget.member.phone,
                            mail: widget.member.mail,
                            address: widget.member.address)),
                  ],
                ),
              );
            } else {
              return EmptyMembershipContainer(message: 'Vous devez être adhérent.e pour accéder à ces informations');
            }
          },
        ),
      ),
    );
  }
}
