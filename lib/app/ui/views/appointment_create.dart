import 'package:flutter/material.dart';
import 'package:hypnose/app/services/agenda_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/widgets/pick_date_time.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentCreateView extends StatefulWidget {
  @override
  _AppointmentCreateViewState createState() => _AppointmentCreateViewState();
}

class _AppointmentCreateViewState extends State<AppointmentCreateView> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _handleAdd(AgendaService agendaService) async {
    bool shouldContinue = false;
    Map<String, dynamic> map = agendaService.appointmentMap;

    if (_userController.text.length > 0 &&
        _descriptionController.text.length > 0) {
      map['userUid'] = _userController.text;
      map['description'] = _descriptionController.text;

      shouldContinue = true;
    }

    if (map['dateTime'] == null) {
      shouldContinue = false;
    }

    if (!shouldContinue) {
      await _showMissingDialog();
    } else {
      var userService = Provider.of<UserService>(context);
      map['adminUid'] = userService.loggedInUser.uid;
      agendaService.appointmentMap = map;

      await agendaService.addAppointment();
      Navigator.pop(context);
    }
  }

  Future _showMissingDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Missing Content'),
              content: Text(
                  'Please provide the name of a user, a description and select the date and time to continue.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Dismiss'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgendaService>(
        builder: (context, AgendaService agendaService, _) {
      return Scaffold(
        floatingActionButton: agendaService.isLoading
            ? FloatingActionButton(
                child: Icon(Icons.cloud_upload),
                onPressed: () {},
              )
            : FloatingActionButton.extended(
                onPressed: () async {
                  await _handleAdd(agendaService);
                },
                icon: Icon(Icons.add),
                label: Text('ADD'),
              ),
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
                child: agendaService.appointmentMap['dateTime'] == null
                    ? PickDateTimeButton()
                    : Text(
                        '${DateFormat.yMMMMd().format(agendaService.appointmentMap['dateTime'])}  ${agendaService.appointmentMap['dateTime'].hour}:${agendaService.appointmentMap['dateTime'].minute}',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
