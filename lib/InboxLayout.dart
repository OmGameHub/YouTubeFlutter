import 'package:flutter/material.dart';

Widget _inboxItem() => 
ListTile(
  onTap: () {},
  contentPadding: EdgeInsets.symmetric(horizontal: 8),
  leading: CircleAvatar(
    radius: 18,
    backgroundImage: NetworkImage('https://yt3.ggpht.com/a/AGF-l7-pLWHhqjLR5ZVoKzV9_eU6IjYrDyhvSLRjsw=s176-c-k-c0x00ffffff-no-rj-mo'),
  ),

  // video title start
  title: Text(
    "Flutter uploaded: Text in Flutter: Building a fancy chat bubble at GDD China",
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 12,
    ),
  ),
  // video title end

  // video upload time start
  subtitle: Text(
    "2 days ago",
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 10,
    ),
  ),
  // video upload time start

  // video thumbnail & popup btn start
  trailing: Container(
    width: 106,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image(
          image: NetworkImage('https://i.ytimg.com/vi/z_moEKHVTAc/hqdefault.jpg'),
          height: 50,
          width: 85,
          fit: BoxFit.cover,
        ),

        Icon(
          Icons.more_vert,
          size: 14,
        ),
      ],
    ),
  ),
  // video thumbnail & popup btn start
);

Widget inboxPageLayout() =>
ListView.builder(
  itemCount: 5,
  itemBuilder: (BuildContext context, int index) => _inboxItem(),
);