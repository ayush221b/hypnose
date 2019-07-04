import 'package:flutter/material.dart';
import 'package:hypnose/app/models/picture.dart';
import 'package:hypnose/app/ui/widgets/picture_viewer_card_details.dart';

class PictureViewer extends StatelessWidget {
  const PictureViewer({
    Key key,
    @required this.pictures,
  }) : super(key: key);

  final List pictures;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pictures.length,
      itemBuilder: (BuildContext context, int index) {
        Picture picture = Picture.fromMap(pictures[index]);
        return Container(
          margin: EdgeInsets.only(top: 40, left: 40, right: 40),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: new PictureViewerCardDetails(picture: picture),
              ),
            ),
          ),
        );
      },
    );
  }
}
