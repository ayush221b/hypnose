import 'package:flutter/material.dart';
import 'package:hypnose/app/models/audio.dart';
import 'package:hypnose/app/services/fetch_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/widgets/audios_list_card.dart';
import 'package:provider/provider.dart';

class MyAudiosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Audios'),
        automaticallyImplyLeading: true,
      ),
      body: Consumer<FetchService>(
        builder:
            (BuildContext context, FetchService fetchService, Widget child) {
          return Consumer<UserService>(
            builder:
                (BuildContext context, UserService userService, Widget child) {
              return StreamBuilder(
                stream: fetchService.getAudiosUploadedByCurrentAdmin(
                    uploaderUid: userService.loggedInUser.uid),
                initialData: [],
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                            'You havent added any audios, please consider adding some.'));
                  } else {
                    if (snapshot.data != null) {
                      List audios = snapshot.data.toList();
                      return Container(
                        child: ListView.builder(
                          padding: EdgeInsets.all(20),
                          itemCount: audios.length,
                          itemBuilder: (BuildContext context, int index) {
                            Audio audio = Audio.fromMap(audios[index]);
                            return AudiosListCard(audio: audio);
                          },
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Audio'),
        icon: Icon(Icons.audiotrack),
        onPressed: () {
          Navigator.pushNamed(context, '/audiocreate');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
