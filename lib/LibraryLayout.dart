import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget _libraryItemWithSubtitle(IconData iconData, String title, String subtitle) => 
ListTile(
  leading: Icon(
    iconData,
    size: 28,
  ),
  title: Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    ),
  ),
  
  subtitle: Text(
    subtitle,
    style: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    ),
  ),
  onTap: () {},
);

Widget _libraryItem(IconData iconData, String title, onTap) => 
ListTile(
  leading: Icon(
    iconData,
    size: 28,
  ),
  title: Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    ),
  ),

  onTap: onTap,
);

Widget libraryPageLayout(toggleTheme) =>
ListView(
  children: <Widget>[
    
    _libraryItem(
      Icons.history,
      "History",
      () {}
    ),

    _libraryItemWithSubtitle(
      Icons.file_download,
      "Download",
      "20 recommendation"
    ),

    _libraryItem(
      FontAwesomeIcons.caretSquareRight,
      "My videos",
      () {}
    ),

    _libraryItem(
      FontAwesomeIcons.tag,
      "Purchase",
      () {}
    ),

    _libraryItemWithSubtitle(
      Icons.file_download,
      "Watch later",
      "Videos you save for later"
    ),
    
    _libraryItem(
      FontAwesomeIcons.adjust,
      "Change Theme",
      toggleTheme
    ),

    Divider(),

    _libraryItem(
      Icons.add,
      "New Playlist",
      () {}
    ),

    _libraryItemWithSubtitle(
      Icons.thumb_up,
      "Watch later",
      "5,000 videos"
    ),
  ],
);