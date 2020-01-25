import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyVideoPage extends StatefulWidget {

  final videoData;
  
  MyVideoPage(this.videoData);

  @override
  _MyVideoPageState createState() => _MyVideoPageState(this.videoData);
}

class _MyVideoPageState extends State<MyVideoPage> {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  bool isAutoPlay = false;

  var videoData;
  List videos;

  _MyVideoPageState(this.videoData);

  @override
  void initState() {
    this._playNextVideo(videoData);
    super.initState();
  }

  @override
  void dispose() {
    this._videoPlayerController.dispose();
    this._chewieController.dispose();
    super.dispose();
  }

  Future getPageDate() async
  {
    String apiLink = "http://userapi.tk/youtube/";
    var respones = await http.get(Uri.encodeFull(apiLink));
    setState(() => this.videos = json.decode(respones.body));
  }

  void _playNextVideo(var video)
  {
    setState(() {
      if (_videoPlayerController != null) 
        this._videoPlayerController.pause();

      if (_chewieController != null) 
        this._chewieController.dispose();

      this.videoData = video;
      this.videos = null;

      String videoUrl = "https" + videoData['VideoURL'].substring(4);

      this._videoPlayerController = VideoPlayerController.network(videoUrl);

      this._chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: false,
      );
    });

    getPageDate();
  }
  
  Widget iconBtn(iconName, text, color) =>
  InkWell(
    customBorder: CircleBorder(),
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[

          Icon(
            iconName,
            size: 18,
            color: color,
          ),

          Container(height: 8,),

          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto-Regular',
              fontWeight: FontWeight.normal,
            ),
          ),

        ],
      ),
    ),

    onTap: () {},
  );

  // next video list start
  Widget nextVideoItem(video) =>
  Center(
    child: Container(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // video thumbnail start
        leading: Image(
          width: 100,
          image: NetworkImage(video['ThumbmnilURL'],),
          fit: BoxFit.cover,
        ),
        // video thumbnail end

        title: Text(
          video['Title'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontWeight: FontWeight.normal,
          ),
        ),

        // video creator name, views & upload time start
        subtitle: Text(
          "${video['Name']}\n${video['Day']}  ${video['Views']}",
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

        onTap: () => this._playNextVideo(video),

      ),
    ),
  );
  // next video list end

  Widget getNextVideos(List videos)
  {
    List<Widget> nextVideos = List();
    for (var i = 0; i < videos.length; i++) 
      nextVideos.add(nextVideoItem(videos[i]));

    return Column(children: nextVideos,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[

            // video player container start
            Container(
              height: 200,
              width: double.infinity,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            // video player container start
            
            Expanded(
              child: ListView(
                children: <Widget>[
                  // video details container start
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(height: 8,),

                              // video title start
                              Text(
                                this.videoData['Title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // video title end

                              Container(height: 8,),

                              // views start
                              Text(
                                videoData['Views'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).textTheme.caption.color,
                                  fontFamily: 'Roboto-Regular',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // views end

                            ],
                          ),
                        ),

                        Icon(
                          FontAwesomeIcons.sortDown,
                          color: Theme.of(context).textTheme.caption.color,
                        ),

                      ],
                    ),
                  ),
                  // video details container end

                  // video likes, dislike, share, download & save container start
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        // likes start
                        iconBtn(
                          Icons.thumb_up,
                          "236",
                          Theme.of(context).textTheme.caption.color
                        ),
                        // likes end

                        // dislikes start
                        iconBtn(
                          Icons.thumb_down,
                          "2",
                          Theme.of(context).textTheme.caption.color
                        ),
                        // dislikes end

                        // share start
                        iconBtn(
                          FontAwesomeIcons.share,
                          "Share",
                          Theme.of(context).textTheme.caption.color
                        ),
                        // share end

                        // download start
                        iconBtn(
                          FontAwesomeIcons.arrowCircleDown,
                          "Download",
                          Theme.of(context).textTheme.caption.color
                        ),
                        // download end

                        // save start
                        iconBtn(
                          Icons.library_add,
                          "Save",
                          Theme.of(context).textTheme.caption.color
                        ),
                        // save end

                      ],
                    ),
                  ),
                  // video likes, dislike, share, download & save container end

                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),

                  // creator channel details start
                  ListTile(
                    // creator image or logo start
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(videoData['ProfileiconURL']),
                    ),
                    // creator image or logo start

                    // creator name start
                    title: Text(videoData['Name']),
                    // creator name end

                    // creator SUBSCRIBED link start
                    subtitle: Text(
                      "SUBSCRIBED",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    // creator SUBSCRIBED link end

                    // notifications start
                    trailing: IconButton(
                      icon: Icon(Icons.notifications_active),
                      color: Theme.of(context).textTheme.caption.color,
                      onPressed: () {},
                    ),
                    // notifications end

                  ),
                  // creator channel details end

                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),

                  // auto play start
                  ListTile(

                    // creator name start
                    title: Text(
                      "Up next",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.caption.color
                      ),
                    ),
                    // creator name end

                    // notifications start
                    trailing: Container(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Text("Autoplay"),

                          Switch(
                            onChanged: (bool value) => setState(() { this.isAutoPlay = value; }), 
                            value: isAutoPlay,
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    // notifications end
                  ),
                  // auto play end

                  // thumbmnilURL, title, name, day, views
                  videos == null
                  ? Center(
                    child: CircularProgressIndicator(),
                  )
                  : getNextVideos(videos),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}