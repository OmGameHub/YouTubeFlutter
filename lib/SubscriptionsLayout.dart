import 'package:flutter/material.dart';

import 'VideoItem.dart';

Widget _channelItem(channel) => 
Container(
  width: 56,
  margin: EdgeInsets.all(8),
  alignment: Alignment.center,
  child: InkWell(
    onTap: () {},
    child: Column(
      children: <Widget>[
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(channel['ProfileiconURL']),
        ),

        Container(height: 8,),

        Text(
          channel['Name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto-Regular',
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  ),
);


Widget _getSubscriptionVideos(List videos, context)
{
  List<Widget> treandingVideos = List();
  for (var i = 0; i < videos.length; i++) 
    treandingVideos.add(videoItem(videos[i], context));

  return Column(children: treandingVideos,);
}

Widget subscriptionsPageLayout(List videos, context) =>
videos == null?
Center(
  child: CircularProgressIndicator(),
) :
SingleChildScrollView(
  child: Container(
    child: Column(
      children: <Widget>[

        // sub channels start
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            itemCount: videos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _channelItem(videos[index]),
          ),
        ),
        // sub channels end

        _getSubscriptionVideos(videos, context),

      ],
    ),
  ),
);