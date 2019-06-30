import 'package:flutter/material.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
import 'package:provider/provider.dart';

class TitleDescriptionPage extends StatefulWidget {
  final PageController controller;
  final bool isAudio;

  const TitleDescriptionPage({this.controller, this.isAudio=true});

  @override
  _TitleDescriptionPageState createState() => _TitleDescriptionPageState();
}

class _TitleDescriptionPageState extends State<TitleDescriptionPage> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  FocusNode myTitleFocusNode;
  FocusNode myDescriptionFocusNode;

  String titleErrorText;
  String descriptionErrorText;

  @override
  void initState() {
    super.initState();

    myTitleFocusNode = FocusNode();
    myDescriptionFocusNode = FocusNode();

    myTitleFocusNode.addListener(() {
      if (myTitleFocusNode.hasFocus) {
        setState(() {
          titleErrorText = null;
        });
      }
    });

    myDescriptionFocusNode.addListener(() {
      if (myDescriptionFocusNode.hasFocus) {
        setState(() {
          descriptionErrorText = null;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myTitleFocusNode.dispose();
    myDescriptionFocusNode.dispose();

    super.dispose();
  }

  bool validateFields() {
    bool shouldProceed = true;

    if (_titleCtrl.text == null || _titleCtrl.text.length < 3) {
      setState(() {
        titleErrorText =
            'The Title is Required and Must have at least 3 Characters';
      });
      shouldProceed = false;
    } else {
      setState(() {
        titleErrorText = null;
      });
    }

    if (_descCtrl.text == null || _descCtrl.text.length < 10) {
      setState(() {
        descriptionErrorText =
            'The Description is Required and Must have at least 10 characters.';
      });
      shouldProceed = false;
    } else {
      setState(() {
        descriptionErrorText = null;
      });
    }

    if (shouldProceed) {
      setState(() {
        titleErrorText = null;
        descriptionErrorText = null;
      });

      if (this.widget.isAudio) {
        var audioUtilService = Provider.of<AudioUtilService>(context);
        Map<String, dynamic> map = audioUtilService.audioMap;

        map['title'] = _titleCtrl.text;
        map['description'] = _descCtrl.text;

        audioUtilService.audioMap = map;
      } else {
        var pictureUtilService = Provider.of<PictureUtilService>(context);
        Map<String, dynamic> map = pictureUtilService.imageMap;

        map['title'] = _titleCtrl.text;
        map['description'] = _descCtrl.text;

        pictureUtilService.imageMap = map;
      }
    }

    return shouldProceed;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.all(8),
          child: Text('Step 1',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor)),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Add the Title and Description',
              style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleCtrl,
              focusNode: myTitleFocusNode,
              decoration: InputDecoration(
                  labelText: 'Title',
                  errorText:
                      !myTitleFocusNode.hasFocus ? titleErrorText : null),
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _descCtrl,
              focusNode: myDescriptionFocusNode,
              maxLines: 4,
              decoration: InputDecoration(
                  labelText: 'Description',
                  errorText: !myDescriptionFocusNode.hasFocus
                      ? descriptionErrorText
                      : null),
            )),
        PageMoveButton(
          controller: widget.controller,
          specialFunction: validateFields,
          isContinue: true,
        )
      ],
    ));
  }
}
