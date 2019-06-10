import 'package:flutter/material.dart';

// Loading Screen presented while authState is Processing
class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Getting things ready for you...',
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: SizedBox(
                height: 2.0,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                )),
          )
        ],
      ),
    );
  }
}
