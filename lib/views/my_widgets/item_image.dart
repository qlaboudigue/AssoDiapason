import 'package:diapason/models/item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/views/my_material.dart';

class ItemImage extends StatelessWidget {

  // PROPERTIES
  final Item item;

  // CONSTRUCTOR
  ItemImage({@required this.item});

  // METHODS
  @override
  Widget build(BuildContext context) {
    if(item.iconImageUrl != null && item.iconImageUrl != '') {
      return CachedNetworkImage(
        imageUrl: item.iconImageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
        ),
        placeholder: (context, url) =>
            ItemIconPlaceholderWidget(),
        errorWidget: (context, url, error) =>
            ItemIconDefaultWidget(),
      );
    } else {
      return ItemIconDefaultWidget();
    }
  }
}
