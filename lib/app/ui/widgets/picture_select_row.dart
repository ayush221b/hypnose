import 'package:flutter/material.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
import 'package:image_picker/image_picker.dart';


class ImageSelectionRow extends StatelessWidget {
  final PictureUtilService pictureUtilService;

  const ImageSelectionRow({Key key, this.pictureUtilService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            label: Text(
              'Capture',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () async {
              await pictureUtilService.getImage(ImageSource.camera);
            },
          ),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            label: Text(
              'Select',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () async {
              await pictureUtilService.getImage(ImageSource.gallery);
            },
          )
        ],
      ),
    );
  }
}