import 'package:flutter/material.dart';
import 'package:hypnose/app/services/agenda_service.dart';
import 'package:provider/provider.dart';

class PickDateTimeButton extends StatefulWidget {
  @override
  _PickDateTimeButtonState createState() => _PickDateTimeButtonState();
}

class _PickDateTimeButtonState extends State<PickDateTimeButton> {
  TimeOfDay _selectedTime;
  DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (picked != null)
      setState(() {
        _selectedTime = picked;
      });
    ;
  }

  @override
  Widget build(BuildContext context) {
    var agendaService = Provider.of<AgendaService>(context);
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.date_range,
        color: Colors.white,
      ),
      label: Text(
        'Pick Date & Time',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        await _selectDate(context);
        await _selectTime(context);

        DateTime dateTime = _selectedDate.add(
            Duration(hours: _selectedTime.hour, minutes: _selectedTime.minute));

        Map<String, dynamic> map = agendaService.appointmentMap;

        map['dateTime'] = dateTime;

        agendaService.appointmentMap = map;
      },
    );
  }
}
