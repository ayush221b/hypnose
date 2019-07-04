import 'package:flutter/material.dart';
import 'package:hypnose/app/services/fetch_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/widgets/picture_viewer.dart';
import 'package:provider/provider.dart';

class MyPicturesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Your Pictures'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Picture'),
        onPressed: () {
          Navigator.of(context).pushNamed('/picturecreate');
        },
        icon: Icon(Icons.add_a_photo),
      ),
      body: Consumer<UserService>(
        builder: (BuildContext context, UserService userService, Widget child) {
          return Consumer<FetchService>(
            builder: (BuildContext context, FetchService fetchService,
                Widget child) {
              return StreamBuilder(
                initialData: [],
                stream: fetchService.getPicturesUploadedByCurrentAdmin(
                  uploaderUid: userService.loggedInUser.uid,
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('No Pictures added. Consider adding some.'),
                    );
                  } else {
                    if (snapshot.data != null) {
                      List pictures = snapshot.data.toList();
                      
                      return PictureViewer(pictures: pictures);
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
