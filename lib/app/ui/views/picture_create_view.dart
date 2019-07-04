import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/widgets/content_assign.dart';
import 'package:hypnose/app/ui/widgets/picture_capture_select.dart';
import 'package:hypnose/app/ui/widgets/title_desc.dart';

class PicturesCreateView extends StatefulWidget {
  @override
  _PicturesCreateViewState createState() => _PicturesCreateViewState();
}

class _PicturesCreateViewState extends State<PicturesCreateView> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Picture'),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          TitleDescriptionPage(controller: _controller, isAudio: false),
          ContentAssignPage(
            controller: _controller,
            isPicture: true,
          ),
          PictureCaptureSelectPage(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
