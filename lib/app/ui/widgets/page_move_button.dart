import 'package:flutter/material.dart';

class PageMoveButton extends StatelessWidget {
  final PageController controller;
  final bool isContinue;
  final Function specialFunction;

  PageMoveButton(
      {this.controller, this.isContinue = true, this.specialFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              if (specialFunction != null) {
                bool canProceed = specialFunction();
                if (canProceed) navigatePage();
              }
              else navigatePage();
            },
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (!isContinue)
                      Icon(
                        !isContinue ? Icons.arrow_left : Icons.arrow_right,
                        color: Colors.white,
                        size: 25,
                      ),
                    Text(
                      isContinue ? 'Continue' : 'Go Back',
                      style: TextStyle(color: Colors.white),
                    ),
                    if (isContinue)
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
    );
  }

  void navigatePage() {
    isContinue
        ? controller.nextPage(
            curve: Curves.easeInOut, duration: Duration(milliseconds: 500))
        : controller.previousPage(
            curve: Curves.easeInOut, duration: Duration(milliseconds: 500));
  }
}
