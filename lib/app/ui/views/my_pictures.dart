import 'package:flutter/material.dart';

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
    );
  }
}
