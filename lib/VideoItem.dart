import 'package:flutter/material.dart';

import 'MyVideoPage.dart';

void openVideo(var videoData, context)
  {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (BuildContext context) => MyVideoPage(videoData))
    );
  }

Widget videoItem(var videoData, context) => 
InkWell(
  onTap: () => openVideo(videoData, context),
  child: Container(
    width: double.infinity,
    child: Column(
      children: <Widget>[

        // video thumbnail end
        Container(
          height: 200,
          width: double.infinity,
          child: Image(
            image: NetworkImage(videoData['ThumbmnilURL']),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // video thumbnail end

        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),

            // creator profile image start
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(videoData['ProfileiconURL']),
            ),
            // creator profile image end

            // video title start
            title: Text(
              videoData['Title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.normal,
              ),
            ),
            // video title end

            // video creator name, views & upload time start
            subtitle: Text(
              "${videoData['Name']}  ${videoData['Views']}  ${videoData['Day']}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.normal,
              ),
            ),
            // video creator name, views & upload time end

            // popup btn start
            trailing: Icon(
              Icons.more_vert,
              size: 18,
            ),
            // popup btn end
          ),
        ),

      ],
    ),
  ),
);