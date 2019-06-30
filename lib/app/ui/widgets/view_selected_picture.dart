import 'package:flutter/material.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';

class ViewSelectedPicture extends StatelessWidget {
  final PictureUtilService pictureUtilService;

  ViewSelectedPicture({@required this.pictureUtilService});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        elevation: 4,
        child: Stack(children: [
          Container(
            height: 300,
            width: 300,
            child: Image.file(
              pictureUtilService.selectedImageFile,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                onPressed: () {
                  pictureUtilService.selectedImageFile = null;
                },
                icon: Icon(Icons.cancel, color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
