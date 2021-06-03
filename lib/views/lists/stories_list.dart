import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/views/pages/story_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class StoriesList extends StatelessWidget {

  final List<Story> storyList;
  final StoryNotifier storyNotifier;

  StoriesList({@required this.storyList, @required this.storyNotifier});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: storyList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index > 0) {
            return StoryBasicTimeLineTile(
              story: storyList[index],
              iconData: storyList[index].storyFieldIconData(),
              storyFunction: () {
                storyNotifier.currentStory = storyList[index];
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context){
                      return StoryPage();
                    })
                );
              },
            );
          } else if (index == 0) {
            return StoryStartingTimeLineTile(
              story: storyList[index],
              storyFunction: () {
                storyNotifier.currentStory = storyList[index];
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context){
                      return StoryPage();
                    })
                );
              },
            );
          } else {
            return EmptyContainer();
          }
        }
    );
  }
}