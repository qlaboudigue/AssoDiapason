import 'package:diapason/views/pages/activities_page.dart';
import 'package:diapason/views/pages/home_page.dart';
import 'package:diapason/views/pages/events_page.dart';
import 'package:diapason/views/pages/items_page.dart';
import 'package:diapason/views/pages/profile_page.dart';
import 'package:diapason/views/pages/stories_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class MainAppNavigationItem {

  // Properties
  final Widget screen;
  final Icon icon;

  // Constructors
  MainAppNavigationItem({
    @required this.screen,
    @required this.icon,
  });

  // Getters/Setters : Getters and setters are special methods that provide read and write access to an object’s properties.
  static List<MainAppNavigationItem> get items => [
    MainAppNavigationItem(
      screen: HomePage(),
      icon: kHomeIcon,
    ),
    MainAppNavigationItem(
      screen: EventsPage(),
      icon: kEventsIcon,
    ),
    MainAppNavigationItem(
      screen: StoriesPage(),
      icon: kStoryIcon,
    ),
    MainAppNavigationItem(
      screen: ActivitiesPage(),
      icon: kActivitiesIcon,
    ),
    MainAppNavigationItem(
      // screen: ProfilePage(me),
      screen: ItemsPage(),
      icon: kItemIcon,
    ),
  ];

}