import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_story_controller.dart';
import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class StoriesPage extends StatefulWidget {

  static String route = 'stories_page';

  @override
  _StoriesPageState createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {

  // STATE PROPERTIES
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
    DiapasonApi().getStories(storyNotifier);
    super.initState();
  }

  Future<void> _getStories() async {
    StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getStories(storyNotifier);
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
              title: AppBarTextWidget(text: 'Stories'),
              actions: <Widget>[
                Consumer<MemberNotifier>(
                  builder: (context, memberNotifier, child) {
                    if(memberNotifier.currentMember.superAdmin == true) {
                      return IconButton(
                        onPressed: () {
                          StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context, listen: false);
                          storyNotifier.currentStory = null;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadStoryController()));
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
            onRefresh: _getStories,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<StoryNotifier>(
              builder: (context, storyNotifier, child) {
                if(storyNotifier.storyList.isNotEmpty && storyNotifier.storyList != null) {
                  return Consumer<MemberNotifier>(
                      builder: (context, memberNotifier, child) {
                        List<Story> _storyList = [];
                        for(Story story in storyNotifier.storyList) {
                          if(!memberNotifier.currentMember.blackList.contains(story.writer)){
                            _storyList.add(story);
                          }
                        }
                        return SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              StoriesList(storyList: _storyList, storyNotifier: storyNotifier),
                              StoryEndTimeLineTile(),
                            ],
                          ),
                        );
                      }
                  );
                } else {
                  return EmptyContainer();
                }
              },
            )
        ),
      ),
    );
  }
}