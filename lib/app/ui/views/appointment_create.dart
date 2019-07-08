import 'package:flutter/material.dart';
import 'package:hypnose/app/ui/widgets/pick_date_time.dart';

class AppointmentCreateView extends StatefulWidget {
  @override
  _AppointmentCreateViewState createState() => _AppointmentCreateViewState();
}

class _AppointmentCreateViewState extends State<AppointmentCreateView> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Appointment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: 'Please Enter User\'s Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: TextField(
                maxLines: 5,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PickDateTimeButton(),
            ),
          ],
        ),
      ),
    );
  }
}