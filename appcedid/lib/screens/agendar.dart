import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as googleapis_auth;
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AgendarPage extends StatelessWidget {
  List<String> dates = [
    'Lunes 08:00-18:00',
    'Martes 08:00-18:00',
    'Miercoles 08:00-18:00',
    'Jueves 08:00-18:00',
    'Viernes 08:00-18:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        title: Text('Agendar Hora', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // Top section
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.blue,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Asesor',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text('Especializacion'),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Middle section
            Expanded(
              flex: 3,
              child: Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: List.generate(10, (index) {
                  return Chip(
                    avatar: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.blue,
                    ),
                    label: Text('Asesor ${index + 1}'),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            // Bottom section
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  // List of dates with time
                  Expanded(
                    child: ListView.builder(
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dates[index]),
                        );
                      },
                    ),
                  ),
                  // Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/calendario');
                    },
                    child: Text('Agendar Hora'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PagCalendario extends StatefulWidget {
  @override
  _PagCalendarioState createState() => _PagCalendarioState();
}

class _PagCalendarioState extends State<PagCalendario> {
  DateTime? _date;
  Duration _duration = Duration(minutes: 15);
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        title: Text('Agendar Hora', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // Top section
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 69.0,
                    backgroundColor: Colors.blue,
                  ),
                  Text(
                    'Reunirse con ese Asesor',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Divider(),
            // Middle section
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue, // Placeholder for the calendar
                child: Center(
                  child: Container(
                    width: 200.0, // Set your desired width
                    height: 50.0, // Set your desired height
                    child: TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022, 1, 1),
                          lastDate: DateTime(2023, 12, 31),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              _date = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                      child: Text(
                        'Seleccionar Fecha y Hora',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            // Bottom section
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    '¿Cuánto tiempo necesitará?',
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _duration = Duration(minutes: 15);
                          });
                        },
                        child: Text('15 minutos'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _duration = Duration(minutes: 30);
                          });
                        },
                        child: Text('30 minutos'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _duration = Duration(hours: 1);
                          });
                        },
                        child: Text('1 hora'),
                      ),
                    ],
                  ),
                  Text(
                    _date != null
                        ? 'Fecha seleccionada: $_date Duración de la reunión: $_duration'
                        : 'No se ha seleccionado ninguna fecha',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Divider(),
            // Button
            ElevatedButton(
              onPressed: () async {
                if (_date != null) {
                  final GoogleSignInAccount? googleUser =
                      await googleSignIn.signIn();

                  if (googleUser != null) {
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;

                    final http.Client httpClient = http.Client();
                    final accessToken = googleAuth.accessToken;
                    final idToken = googleAuth.idToken;
                    final expiryTime = DateTime.now()
                        .add(Duration(hours: 1))
                        .toUtc(); // Set expiry time
                    final scopes = <String>[
                      'https://www.googleapis.com/auth/calendar'
                    ]; // Set scopes
                    final credentials = googleapis_auth.AccessCredentials(
                      googleapis_auth.AccessToken(
                          'Bearer', accessToken!, expiryTime),
                      idToken,
                      scopes,
                    );
                    final authenticatedClient = googleapis_auth
                        .authenticatedClient(httpClient, credentials);

                    final start = gcal.EventDateTime()
                      ..dateTime = _date
                      ..timeZone = 'America/Santiago';
                    final end = gcal.EventDateTime()
                      ..dateTime = _date!.add(_duration)
                      ..timeZone = 'America/Santiago';
                    final calendar = gcal.CalendarApi(authenticatedClient);
                    final event = gcal.Event()
                      ..summary = 'Reunión con Asesor'
                      ..start = start
                      ..end = end;
                    await calendar.events.insert(event, 'primary');
                  }
                }
              },
              child: Text('Agendar Hora'),
            ),
          ],
        ),
      ),
    );
  }
}
