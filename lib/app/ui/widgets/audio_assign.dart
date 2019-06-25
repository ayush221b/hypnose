import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';

class AudiocategoryUserAssignPage extends StatefulWidget {
  final PageController controller;

  AudiocategoryUserAssignPage(this.controller);

  @override
  _AudiocategoryUserAssignPageState createState() =>
      _AudiocategoryUserAssignPageState();
}

class _AudiocategoryUserAssignPageState
    extends State<AudiocategoryUserAssignPage> {
  bool _isSwitchedAssignTo = false;
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
                    'Assign a Category or a User',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Switch(
                  value: _isSwitchedAssignTo,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitchedAssignTo = value;
                    });
                  },
                  inactiveThumbColor: Colors.blue,
                  inactiveTrackColor: Colors.cyan,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: _isSwitchedAssignTo
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
                decoration: InputDecoration(labelText: 'Start Typing the Name'),
              )),
          PageMoveButton(
            controller: this.widget.controller,
            isContinue: true,
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
