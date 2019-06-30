import 'package:flutter/material.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
import 'package:hypnose/app/ui/widgets/picture_select_row.dart';
import 'package:hypnose/app/ui/widgets/upload_fire.dart';
import 'package:hypnose/app/ui/widgets/view_selected_picture.dart';
import 'package:provider/provider.dart';

class PictureCaptureSelectPage extends StatelessWidget {
  final PageController controller;

  PictureCaptureSelectPage({this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<PictureUtilService>(
      builder: (BuildContext context, PictureUtilService pictureUtilService,
          Widget child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.all(8),
                child: Text('Step 3',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Choose an Image File or Capture Now',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  )),
              if (pictureUtilService.selectedImageFile != null)
                ViewSelectedPicture(
                  pictureUtilService: pictureUtilService,
                )
              else
                ImageSelectionRow(
                  pictureUtilService: pictureUtilService,
                ),
              
              UploadFireWidget(
                isAudio: false,
              ),
              PageMoveButton(
                isContinue: false,
                controller: controller,
              )
            ],
          ),
        );
      },
    );
  }
}
