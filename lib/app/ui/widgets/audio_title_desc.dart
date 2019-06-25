import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';

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
        PageMoveButton(
          controller: _controller,
          isContinue: true,
        )
      ],
    ));
  }
}
