import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/models/event.dart';

class EventImage extends DecorationImage {

  EventImage(Event event): super(
        image: (event.imageUrl != null && event.imageUrl != '') ? CachedNetworkImageProvider(event.imageUrl) : kEventExistingDefaultImage,
        fit: BoxFit.cover
  );

}