import 'package:flutter/material.dart';

class AudioTitleDescriptionPage extends StatelessWidget {
  const AudioTitleDescriptionPage({
    Key key,
    @required PageController controller,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Title of Audio'),
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Description of Audio'),
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
    ));
  }
}