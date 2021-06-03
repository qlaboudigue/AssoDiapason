import 'package:diapason/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/views/my_material.dart';

class ActivityImage extends Container {

  ActivityImage({
    @required Activity activity
  }): super (
    height: 55.0,
    width: 55.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
          image: (activity.iconImageUrl != null && activity.iconImageUrl != '') ? CachedNetworkImageProvider(activity.iconImageUrl) : kActivityDefaultImage,
        fit: BoxFit.cover,
    )
  ),
  );
}