import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/controllers/upload_story_controller.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  //PROPERTIES
  Story _currentStory;

  @override
  void initState() {
    super.initState();
    StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
    if (storyNotifier.currentStory != null) {
      _currentStory = storyNotifier.currentStory;
    }
  }

  void _updateStory() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UploadStoryController())); // Modify activity
  }

  void _deleteStory(StoryNotifier storyNotifier) {
    Navigator.pop(context);
    DiapasonApi().deleteStory(storyNotifier); // Delete activity
    Navigator.pop(context);
  }

  void _flagStory(StoryNotifier storyNotifier) {
    Navigator.pop(context);
    ClaimNotifier claimNotifier =
    Provider.of<ClaimNotifier>(context, listen: false);
    Claim _currentClaim = Claim();
    _currentClaim.content = storyNotifier.currentStory.title;
    _currentClaim.type = _currentClaim.claimTypeList[2];
    claimNotifier.currentClaim = _currentClaim;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UploadClaimController()));
  }

  void _blackListAuthor(MemberNotifier memberNotifier, StoryNotifier storyNotifier) {
    Navigator.pop(context);
    Navigator.pop(context);
    DiapasonApi()
        .blackListMember(memberNotifier, storyNotifier.currentStory.writer);
  }

  Future<void> _loadAssets() async {
    List<Asset> _resultList;
    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: 7,
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(
          backgroundColor: "#000000",
          selectionFillColor: "#F99E60",
          selectionTextColor: "#FFFFFF",
          selectionCharacter: "✓",
        ),
        materialOptions: MaterialOptions(
          actionBarTitle: "Action bar",
          allViewTitle: "All view title",
          actionBarColor: "#aaaaaa",
          actionBarTitleColor: "#bbbbbb",
          lightStatusBar: false,
          statusBarColor: '#abcdef',
          startInAllView: true,
          selectCircleStrokeColor: "#000000",
          selectionLimitReachedText: "You can't select any more.",
        ),
      );
    } on Exception catch (e) {
      return e;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    // Upload pictures in BDD
    StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
    DiapasonApi().uploadStoryPictures(storyNotifier, _currentStory, _resultList);
  }

  List<Widget> _buildPicturesWidgetList(List<dynamic> picturesUrl) {
    // Build list of images and build layout from currentItem.picturesUrl
    List<Widget> _picturesWidgetList = [];
    if (picturesUrl != null && picturesUrl.isNotEmpty) {
      for (int i = 0; i < picturesUrl.length; i++) {
        StoryPictureTile _pictureTile;
        _pictureTile = StoryPictureTile(picturesUrl[i].toString());
        _picturesWidgetList.add(_pictureTile);
      }
      return _picturesWidgetList;
    } else {
      // Input list empty or null => Layout with loading pictures display
      for (int i = 0; i < 8; i++) {
        StoryEmptyPictureTile _pictureTile;
        _pictureTile = StoryEmptyPictureTile(i+1);
        _picturesWidgetList.add(_pictureTile);
      }
      return _picturesWidgetList;
    }
  }

  List<StaggeredTile> _buildLayout(List<dynamic> picturesList) {
    List<StaggeredTile> _staggeredTilesList = [];
    List<StaggeredTile> _staggeredTilesFullLayout = <StaggeredTile> [
      StaggeredTile.count(4, 2),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 3),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 1),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(3, 1),
    ];
    if(picturesList != null) {
      if(picturesList.isNotEmpty) {
        for(int i = 0; i < picturesList.length; i++) {
          _staggeredTilesList.add(_staggeredTilesFullLayout[i]);
        }
        return _staggeredTilesList;
      } else {
        _staggeredTilesList = _staggeredTilesFullLayout;
        return _staggeredTilesList;
      }
    } else {
      _staggeredTilesList = _staggeredTilesFullLayout;
      return _staggeredTilesList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBarBackgroundColor,
          elevation: 10.0,
          centerTitle: true, // android override
          title: Consumer<StoryNotifier>(
            builder: (context, storyNotifier, child) {
              return AppBarTextWidget(text: storyNotifier.currentStory.title);
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
                StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
                MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
                AlertHelper().showStoriesOptions(
                  context,
                  memberNotifier.currentMember,
                  storyNotifier.currentStory,
                  () => _updateStory(),
                  () => _deleteStory(storyNotifier),
                  () => _flagStory(storyNotifier),
                  () => _blackListAuthor(memberNotifier, storyNotifier),
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
        floatingActionButton: Consumer<MemberNotifier>(
          builder: (context, memberNotifier, child) {
            if(memberNotifier.currentMember.superAdmin == true) {
              return FloatingActionButton(
                elevation: 10.0,
                onPressed: () {
                  // Upload pictures
                  _loadAssets();
                },
                child: Icon(Icons.flip_camera_ios_rounded, size: 30.0,),
                foregroundColor: kDarkGreyColor,
                backgroundColor: kOrangeMainColor,
              );
            } else {
              return EmptyContainer();
            }
          },
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
              Consumer<StoryNotifier>(builder: (context, storyNotifier, child) {
                if (storyNotifier.currentStory != null && storyNotifier.currentStory.picturesUrl != null) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 70.0),
                    child: StaggeredGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      staggeredTiles: _buildLayout(storyNotifier.currentStory.picturesUrl),
                      children: _buildPicturesWidgetList(storyNotifier.currentStory.picturesUrl),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: EdgeInsets.all(4.0),
                    ),
                  );
                } else {
                  return EmptyContainer();
                }
              }),
            ],
          ),
        )));
  }
}





