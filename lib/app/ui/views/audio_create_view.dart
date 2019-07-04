import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/widgets/content_assign.dart';
import 'package:hypnose/app/ui/widgets/audio_record_pick.dart';
import 'package:hypnose/app/ui/widgets/title_desc.dart';

class AudioCreateView extends StatefulWidget {
  @override
  _AudioCreateViewState createState() => _AudioCreateViewState();
}

class _AudioCreateViewState extends State<AudioCreateView> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Audio'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          TitleDescriptionPage(controller: _controller),
          // Second Page
          ContentAssignPage(
            controller: _controller,
            isPicture: false,
          ),
          //Third Page
          AudioPickRecordPage(_controller),
        ],
      ),
    );
  }
}
