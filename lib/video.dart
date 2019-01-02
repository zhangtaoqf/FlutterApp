import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qsbk_flutter/common.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new VideoListWidget();
  }
}

class VideoListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new VideoListWidgetState();
  }
}

class VideoListWidgetState extends State<VideoListWidget>
    with SingleTickerProviderStateMixin {
  List<dynamic> data;
  http.Client client;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (client != null) {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: new ListView(
        children: _getChildren(),
      ),
    );
  }

  void loadData() {
    client = new http.Client();
    client
        .get("https://m2.qiushibaike.com/article/list/video")
        .then((response) {
          //dynamic 类似于JSONArray类型
          if (response.statusCode == 200) {
            dynamic dataJS = json.decode(response.body);
            print(response.body);
            data = dataJS["items"];
            //更新界面
            setState(() {});
          }
        })
        .catchError(dealError)
        .whenComplete(() {
          client.close;
        });
  }

  List<Widget> _getChildren() {
    List<Widget> widgets = new List();
    if (data == null) {
      widgets.add(new Center(
        child: new Text("数据为空"),
      ));
    } else {
      for (var map in data) {
        widgets.add(getItemWidget(map));
      }
    }
    return widgets;
  }

  final String defaultThumb = "";

  Widget getItemWidget(Map<String, dynamic> map) {
    return new Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                width: 30,
                height: 30,
                child: map["user"] != null && map["user"]["thumb"] != null
                    ? Image.network(map["user"]["thumb"])
                    : Container(),
              ),
              Text(
                map["user"] != null && map["user"]["login"] != null
                    ? map["user"]["login"]
                    : " ",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              map["content"],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          new GestureDetector(
            onTap: () {
              lookVideo(map);
            },
            child: new Container(
              child: FadeInImage.assetNetwork(
                placeholder: "images/splash.jpg",
                image: map["pic_url"],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void lookVideo(dynamic videoData) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new VideoPlayerPage(videoData)));
  }

  dealError(dynamic error) {
    print(error.toString());
  }
}
