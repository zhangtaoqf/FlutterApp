import 'package:flutter/material.dart';
import 'package:qsbk_flutter/artical.dart';
import 'package:qsbk_flutter/pic.dart';
import 'package:qsbk_flutter/video.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      home: new HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeContainerState();
  }
}

class HomeContainerState extends State<HomeContainer> {
  int curIndex = 0;

  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: new Icon(Icons.message), title: new Text("文章")),
        BottomNavigationBarItem(
            icon: new Icon(Icons.video_label), title: new Text("视频")),
        BottomNavigationBarItem(
            icon: new Icon(Icons.photo), title: new Text("图片")),
      ], currentIndex: curIndex, onTap: bottomNavigationBarSelect),
      body: new PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return new ArticalPage();
            case 1:
              return new VideoPage();
            case 2:
              return new PicPage();
            default:
              return new ArticalPage();
          }
        },
        itemCount: 3,
        onPageChanged: onPageChanged,
        controller: pageController,
      ),
    );
  }

  void onPageChanged(int index) {
    curIndex = index;
    setState(() {});
  }

  void bottomNavigationBarSelect(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
