import 'package:flutter/material.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
import 'package:provider/provider.dart';

class ContentAssignPage extends StatefulWidget {
  final PageController controller;
  final bool isPicture;

  ContentAssignPage({this.controller, this.isPicture = false});

  @override
  _ContentAssignPageState createState() => _ContentAssignPageState();
}

class _ContentAssignPageState extends State<ContentAssignPage> {
  bool _shouldAssignCategory = false;
  TextEditingController _assignedToController = TextEditingController();
  FocusNode myFocusNode;

  String fieldErrorText;

  bool validateFields() {
    bool shouldProceed = true;

    if (_assignedToController.text == null ||
        _assignedToController.text.length < 1) {
      setState(() {
        fieldErrorText = 'This field cannot be empty.';
      });
      shouldProceed = false;
    } else
      setState(() {
        fieldErrorText = null;
      });

    if (shouldProceed) {
      if (!this.widget.isPicture) {
        var audioUtilService = Provider.of<AudioUtilService>(context);
        Map<String, dynamic> map = audioUtilService.audioMap;

        _shouldAssignCategory
            ? map['category'] = _assignedToController.text
            : map['userUid'] = _assignedToController.text;

        audioUtilService.audioMap = map;
      } else {
        var pictureUtilService = Provider.of<PictureUtilService>(context);

        Map<String, dynamic> map = pictureUtilService.imageMap;

        map['category'] = _assignedToController.text;

        pictureUtilService.imageMap = map;
      }
    }

    return shouldProceed;
  }

  @override
  void initState() {
    myFocusNode = FocusNode();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        setState(() {
          fieldErrorText = null;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.all(8),
            child: Text('Step 2',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor)),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              padding: EdgeInsets.all(8.0),
              child: Text(
                this.widget.isPicture
                    ? 'Assign a Category'
                    : 'Assign a Category or a User',
                style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              )),
          if (!this.widget.isPicture)
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Switch(
                    value: _shouldAssignCategory,
                    onChanged: (bool value) {
                      setState(() {
                        _shouldAssignCategory = value;
                      });
                    },
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.cyan,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: _shouldAssignCategory
                        ? Text(
                            'Assign a Category',
                            style: TextStyle(fontSize: 20),
                          )
                        : Text(
                            'Assign a User',
                            style: TextStyle(fontSize: 20),
                          ),
                  )
                ],
              ),
            ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              padding: EdgeInsets.all(8.0),
              child: TextField(
                focusNode: myFocusNode,
                controller: _assignedToController,
                decoration: InputDecoration(
                    labelText: 'Please Enter',
                    errorText: fieldErrorText ?? null),
              )),
          PageMoveButton(
            controller: this.widget.controller,
            isContinue: true,
            specialFunction: validateFields,
          ),
          PageMoveButton(
            controller: this.widget.controller,
            isContinue: false,
          ),
        ],
      ),
    );
  }
}
