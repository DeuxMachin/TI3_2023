import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_io.dart' as googleapis_auth;
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MeetingsPage extends StatefulWidget {
  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? loggedInUser;
  List<Map<String, dynamic>> meetings = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMeetings();
  }

  void getCurrentUser() {
    loggedInUser = _auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reuniones', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          final meeting = meetings[index];
          DateTime dateTimeStart = DateTime.parse(meeting['start']);
          String formattedDateStart =
              DateFormat('dd-MM-yyyy – HH:mm').format(dateTimeStart);
          DateTime dateTimeEnd = DateTime.parse(meeting['end']);
          String formattedDateEnd = DateFormat('HH:mm').format(dateTimeEnd);
          return ListTile(
            title: Text(meeting['summary']),
            subtitle: Text('$formattedDateStart - $formattedDateEnd'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmar eliminación'),
                      content: Text(
                          '¿Estás seguro de que quieres eliminar esta reunión?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Eliminar',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                ).then((_) async {
                  // This block runs after the confirmation dialog is dismissed
                  await deleteMeeting(meeting);
                  getMeetings(); // Reload meetings

                  // Show success message dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reunión cancelada'),
                        content: Text('Hora cancelada correctamente.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Continuar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              },
            ),
          );
        },
      ),
    );
  }

  //Get the meetings assigned to a particular email
  Future<void> getMeetings() async {
    if (loggedInUser != null) {
      final firestore = FirebaseFirestore.instance;
      final userMeetings = await firestore
          .collection('reunion')
          .where('email', isEqualTo: loggedInUser!.email)
          .get();

      meetings = userMeetings.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      setState(() {});
    }
  }

  Future<void> deleteMeeting(Map<String, dynamic> meeting) async {
    //Delete from Firestore
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('reunion').doc(meeting['id']).delete();

    //Delete from Google Calendar while checking the Authentication
    final googleSignIn = GoogleSignIn(scopes: [gcal.CalendarApi.calendarScope]);
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    final expiryTime = DateTime.now().add(Duration(hours: 1)).toUtc();
    final scopes = <String>['https://www.googleapis.com/auth/calendar'];
    final credentials = googleapis_auth.AccessCredentials(
      googleapis_auth.AccessToken('Bearer', accessToken!, expiryTime),
      idToken,
      scopes,
    );
    final http.Client client =
        googleapis_auth.authenticatedClient(http.Client(), credentials);
    final calendarApi = gcal.CalendarApi(client);

    await calendarApi.events.delete('primary', meeting['googleEventId']);
  }
}
