import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PhotosPage extends StatelessWidget {
  String pic;

  PhotosPage(this.pic);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: new Container(
        child: FadeInImage.assetNetwork(
            placeholder: "images/splash.jpg", image: pic),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  dynamic videoData;

  VideoPlayerPage(this.videoData);

  @override
  State<StatefulWidget> createState() {
    return new VideoPlayerPageState(videoData);
  }
}

class VideoPlayerPageState extends State<VideoPlayerPage>
    with SingleTickerProviderStateMixin {
  dynamic videoData;

  double aspectRatio = 1 / 2;

  VideoPlayerPageState(this.videoData);

  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (videoData == null || videoData["high_url"] == null) {
      Navigator.pop(context);
    } else {
      List<dynamic> size = videoData["pic_size"];
      dynamic wid = size[0];
      dynamic hei = size[1];
      aspectRatio = wid / hei;
      videoPlayerController =
          new VideoPlayerController.network(this.videoData["high_url"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: new Chewie(
        videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: aspectRatio,
        showControls: false,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
}
