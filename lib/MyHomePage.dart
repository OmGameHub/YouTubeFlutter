import 'dart:io';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_app/MyVideoPage.dart';
import 'dart:convert';

import 'main.dart';

import 'HomeLayout.dart';
import 'TrendingLayout.dart';
import 'SubscriptionsLayout.dart';
import 'InboxLayout.dart';
import 'LibraryLayout.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String homePageApi = "http://userapi.tk/youtube/";
  String trendingPageApi = "http://userapi.tk/youtube/trending";
  String subscriptionPageApi = "http://userapi.tk/youtube/subscription";

  int _selectedIndex = 0;

  List pageData;

  bool isInternetConn = true;

  @override
  void initState() {
    getPageDate(this.homePageApi);
    super.initState();
  }

  Future getPageDate(String apiLink) async
  {
    try 
    {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) 
      {
        var respones = await http.get(Uri.encodeFull(apiLink));
        List converted = json.decode(respones.body);

        setState(() {
          this.pageData = converted;
          this.isInternetConn = true;
        });
      }
      else
      {
        setState(() => this.isInternetConn = false);
      }
    } 
    on SocketException catch (_) 
    {
      print('not connected');
      setState(() => this.isInternetConn = false);
    }
  }

  void toggleTheme()
  {
    DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark
    );

    DynamicTheme.of(context).setThemeData(
        Theme.of(context).brightness == Brightness.dark? lightTheme : ThemeData.dark()
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (this._selectedIndex) 
    {
      case 0: 
        setState(() { this.pageData = null; });
        getPageDate(this.homePageApi);
        break;

      case 1: 
        setState(() { this.pageData = null; });
        getPageDate(this.trendingPageApi);
        break;

      case 2: 
        setState(() { this.pageData = null; });
        getPageDate(this.subscriptionPageApi);
        break;
    }
  }

  Widget getLayout()
  {
    switch (this._selectedIndex) 
    {
      case 0: return !this.isInternetConn
        ? this.retryLayout(this.homePageApi)
        : homePageLayout(this.pageData, context);

      case 1: return !this.isInternetConn
        ? this.retryLayout(this.trendingPageApi)
        : treandingPageLayout(this.pageData, context);

      case 2: return !this.isInternetConn
        ? this.retryLayout(this.subscriptionPageApi)
        : subscriptionsPageLayout(this.pageData, context);

      case 3: return inboxPageLayout();

      case 4: return libraryPageLayout(this.toggleTheme);
    }
  }

  Widget retryLayout(apiLink) => 
  Center(
    child: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Check you internet connection",
            style: TextStyle(
              fontSize: 18,
            ),
          ),

          Container(height: 16,),

          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue,
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => this.getPageDate(apiLink),
          )
        ],
      ),
    ),
  );

  // bottom navigation bar start
  Widget _bottomNavigationBar() =>
  BottomNavigationBar(
    currentIndex: this._selectedIndex,
    type: BottomNavigationBarType.fixed,
    iconSize: 20,
    selectedItemColor: Theme.of(context).brightness == Brightness.light? Colors.red : Colors.white,
    selectedFontSize: 11,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    ),
    unselectedFontSize: 11,
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    ),
    onTap: this._onItemTapped,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.whatshot),
        title: Text('Trending'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.subscriptions),
        title: Text('Subscriptions'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.email),
        title: Text('Inbox'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.video_library),
        title: Text('Library'),
      ),
    ],
  );
   // bottom navigation bar end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Container(
                  height: 12,
                  width: 12,
                  color: Colors.white,
                ),

                Icon(
                  FontAwesomeIcons.youtube, 
                  color: Colors.red,
                ),
              ],
            ),

            Container(width: 8,),

            Text(
              "YouTube",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[

          // live video start
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          // live video end

          // search video start
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          // search video end

          // user account start
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
          // user account end

        ],
      ),
      body: this.getLayout(),
      bottomNavigationBar: this._bottomNavigationBar(),
    );
  }
}