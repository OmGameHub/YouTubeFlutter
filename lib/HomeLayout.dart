import 'package:flutter/material.dart';

import 'VideoItem.dart';

Widget homePageLayout(List videos, context) =>
videos == null?
Center(
  child: CircularProgressIndicator(),
) :
ListView.builder(
  itemCount: videos.length,
  itemBuilder: (BuildContext context, int index) => 
  videoItem(videos[index], context),
);