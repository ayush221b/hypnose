import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/host_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

class UploadFireWidget extends StatelessWidget {
  const UploadFireWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioUtilService = Provider.of<AudioUtilService>(context);
    return Consumer<HostService>(
      builder: (BuildContext context, HostService hostService, Widget child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: hostService.isUploading
                ? SpinKitDoubleBounce(color: Theme.of(context).primaryColor,)
                : RaisedButton.icon(
                    color: Theme.of(context).primaryColor,
                    label: Text(
                      'Upload & Add Audio',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      var userService = Provider.of<UserService>(context);

                      Map<String, dynamic> map = audioUtilService.audioMap;

                      map['uploaderUid'] = userService.loggedInUser.uid;
                      map['dateTime'] = DateTime.now();

                      await hostService.uploadToStorage(
                          uri: audioUtilService.audioFilePath, isAudio: true);

                      if (hostService.downloadUrl != null) {
                        map['downloadUrl'] = hostService.downloadUrl;

                        audioUtilService.audioMap = map;

                        await hostService.updateFirestoreEntry(
                            isAudio: true,
                            objectMap: audioUtilService.audioMap);
                        
                        audioUtilService.clearPreviousAudioData();

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