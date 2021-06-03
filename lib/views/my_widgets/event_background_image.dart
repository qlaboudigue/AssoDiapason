import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EventBackgroundImage extends Container {

  EventBackgroundImage({
    @required String urlString,
    @required BuildContext context,
  }) : super(
    width: MediaQuery.of(context).size.width,
    height: (MediaQuery.of(context).size.width * 9) / 20,
    decoration: BoxDecoration(
        image: DecorationImage(
          // onError: ,
          image:(urlString != null && urlString != '') ? CachedNetworkImageProvider(urlString,) : kEventDefaultImage,
          fit: BoxFit.cover,
        )),
  );
}