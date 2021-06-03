import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class StoryPictureTile extends StatelessWidget {

  final String imageUrl;

  StoryPictureTile(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kDrawerDividerColor,
      child: Center(
        child: Padding(
            padding: EdgeInsets.all(3.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(2.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  BackgroundImagePlaceholderWidget(),
              errorWidget: (context, url, error) =>
                  ItemBackgroundDefaultImage(),
            )
        ),
      ),
    );
  }
}