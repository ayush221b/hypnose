import 'package:flutter/material.dart';

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
        children: <Widget>[
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    this.widget.controller.previousPage(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 100));
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                            size: 25,
                          ),
                          Text(
                            'Go Back',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    this.widget.controller.nextPage(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 100));
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
