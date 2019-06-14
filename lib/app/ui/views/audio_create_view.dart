import 'package:flutter/material.dart';

class AudioCreateView extends StatefulWidget {
  @override
  _AudioCreateViewState createState() => _AudioCreateViewState();
}

class _AudioCreateViewState extends State<AudioCreateView> {
  bool _isSwitched = false;

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
          SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add the Title and Description for the new Audio',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  )),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Title of Audio'),
                  )),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 4,
                    decoration:
                        InputDecoration(labelText: 'Description of Audio'),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _controller.nextPage(
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
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )
            ],
          )),
          // Next Page
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Switch(
                        value: _isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            _isSwitched = value;
                          });
                        },
                        inactiveThumbColor: Colors.blue,
                        inactiveTrackColor: Colors.cyan,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: _isSwitched
                            ? Text('Assign a Category', style: TextStyle(fontSize: 20),)
                            : Text('Assign a User', style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
