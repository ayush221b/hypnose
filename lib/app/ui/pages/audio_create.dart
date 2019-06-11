/*  This screen handles the process of adding a new audio file to the database.
* The file can either be picked from the file system of the phone or recorded
* in the app itself.
*/

import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/views/audio_create_view.dart';

class AudioCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AudioCreateView();
  }
}