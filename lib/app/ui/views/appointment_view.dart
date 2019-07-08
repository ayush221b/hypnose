import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hypnose/app/models/appointment.dart';
import 'package:hypnose/app/services/agenda_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/appointment_create'),
        child: Icon(Icons.add),
      ),
      body: Consumer<AgendaService>(
        builder:
            (BuildContext context, AgendaService agendaService, Widget child) {
          var userService = Provider.of<UserService>(context);

          return StreamBuilder(
            initialData: [],
            stream:
                agendaService.getAgenda(adminUid: userService.loggedInUser.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List appointments = snapshot.data.toList();
              if (appointments.length > 0) {
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    Appointment appointment = appointments[index];
                    return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Stack(
                          children: <Widget>[
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30)),
                              child: Container(
                                constraints: BoxConstraints(minHeight: 220),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${DateFormat.yMMMMd().format(appointment.dateTime.toDate())}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '${appointment.dateTime.toDate().hour}: ${appointment.dateTime.toDate().minute}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'With ${appointment.userUid}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'About\n\n${appointment.description}',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  appointment.dateTime
                                              .compareTo(Timestamp.now()) >
                                          0
                                      ? 'Upcoming'.toUpperCase()
                                      : 'Passed'.toUpperCase(),
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                );
              } else {
                return Center(
                  child: Text('No Appointments Found.'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
