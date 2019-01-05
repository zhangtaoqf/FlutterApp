import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ArticalListWidget();
  }
}

class ArticalListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ArticalListWidgetState();
  }
}

class ArticalListWidgetState extends State<ArticalListWidget>
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

  List<Widget> _getChildren() {
    List<Widget> widgets = new List();
    if (data != null) {
      for (dynamic map in data) {
        widgets.add(getItemWidget(map));
      }
    } else {
      widgets.add(new Container());
    }
    return widgets;
  }

  void loadData() {
    client = new http.Client();
    client
        .get("https://m2.qiushibaike.com/article/list/text")
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

  Widget getItemWidget(map) {
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
                child: new ClipOval(
                  child: map["user"] != null && map["user"]["thumb"] != null
                      ? Image.network(map["user"]["thumb"])
                      : Container(),
                ),
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
          Text(
            map["content"],
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  dealError(dynamic error) {
    print(error.toString());
  }
}
