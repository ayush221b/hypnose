import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/host_service.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

class UploadFireWidget extends StatelessWidget {
  final bool isAudio;

  const UploadFireWidget({Key key, this.isAudio = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HostService>(
      builder: (BuildContext context, HostService hostService, Widget child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: hostService.isUploading
                ? SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                  )
                : RaisedButton.icon(
                    color: Theme.of(context).primaryColor,
                    label: Text(
                      'Upload & Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      var userService = Provider.of<UserService>(context);
                      var audioUtilService =
                          Provider.of<AudioUtilService>(context);
                      var pictureUtilService =
                          Provider.of<PictureUtilService>(context);

                      Map<String, dynamic> map = isAudio
                          ? audioUtilService.audioMap
                          : pictureUtilService.imageMap;

                      map['uploaderUid'] = userService.loggedInUser.uid;
                      map['dateTime'] = DateTime.now();

                      String fileUri = isAudio
                          ? audioUtilService.audioFilePath
                          : pictureUtilService.selectedImageFile.path;

                      await hostService.uploadToStorage(
                          uri: fileUri, isAudio: isAudio);

                      if (hostService.downloadUrl != null) {
                        map['downloadUrl'] = hostService.downloadUrl;

                        isAudio
                            ? audioUtilService.audioMap = map
                            : pictureUtilService.imageMap = map;

                        await hostService.updateFirestoreEntry(
                            isAudio: isAudio,
                            objectMap: isAudio
                                ? audioUtilService.audioMap
                                : pictureUtilService.imageMap);

                        isAudio
                            ? audioUtilService.clearPreviousAudioData()
                            : pictureUtilService.clearPreviousPicturedata();

                        Navigator.pop(context);
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
