import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

class PictureUtilService extends ChangeNotifier {
  /// The file of the image that's selected
  File _selectedImageFile;

  File get selectedImageFile => _selectedImageFile;

  set selectedImageFile(File image) {
    _selectedImageFile = image;
    notifyListeners();
  }

  /// The Map to store all db details of the image being uploaded
  Map<String, dynamic> _imageMap = {};

  Map<String, dynamic> get imageMap => _imageMap;

  set imageMap(Map<String, dynamic> map) {
    _imageMap = map;
    print(_imageMap);
    notifyListeners();
  }

  Future getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      _selectedImageFile = image;
    }

    notifyListeners();
  }

  // function to clear previously recorded audio data
  void clearPreviousPicturedata() {
    _selectedImageFile = null;
  }

}
