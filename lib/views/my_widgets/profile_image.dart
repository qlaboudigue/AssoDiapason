import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/views/my_material.dart';

class ProfileImage extends CircleAvatar {

  ProfileImage({
    @required double size,
    @required String urlString,
    @required Color color,
    @required Function onTap
  }): super (
    radius: size + 3,
    backgroundColor: color,
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: size,
        backgroundImage: (urlString != null && urlString != '') ? CachedNetworkImageProvider(urlString,) : kProfileDefaultImage,
      ),
    ),
  );

}