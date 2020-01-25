import 'package:flutter/material.dart';

import 'VideoItem.dart';

Widget _treandingCategoryItem(String imageUrl, String category) => 
Container(
  margin: EdgeInsets.only(bottom: 8),
  child: Column(
    children: <Widget>[

      CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(imageUrl),
      ),

      Container(height: 8,),

      Text(
        category,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto-Regular',
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  ),
);

Widget getTreandingVideos(List videos, context)
{
  List<Widget> treandingVideos = List();
  for (var i = 0; i < videos.length; i++) 
    treandingVideos.add(videoItem(videos[i], context));

  return Column(children: treandingVideos,);
}

Widget treandingPageLayout(List videos, context) =>
videos == null?
Center(
  child: CircularProgressIndicator(),
) :
SingleChildScrollView(
  child: Container(
    child: Column(
      children: <Widget>[

        // treanding category start
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              _treandingCategoryItem(
                'https://youtube.com/img/trending/chips/music_320x320.png',
                "Music"
              ),
              
              _treandingCategoryItem(
                'https://youtube.com/img/trending/chips/gaming_320x320.png',
                "Gaming"
              ),

              _treandingCategoryItem(
                'https://youtube.com/img/trending/chips/news_320x320.png',
                "News"
              ),

              _treandingCategoryItem(
                'https://youtube.com/img/trending/chips/movies_80x80.png',
                "Movies"
              ),
              
              _treandingCategoryItem(
                'https://youtube.com/img/trending/chips/fashion_80x80.png',
                "Fashion"
              ),

            ],
          ),
        ),
        // treanding category end

        getTreandingVideos(videos, context),

      ],
    ),
  ),
);