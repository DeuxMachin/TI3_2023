import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as googleapis_auth;
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ti3/main.dart';
import 'package:ti3/screens/showmeetings.dart';
import 'package:table_calendar/table_calendar.dart';
import 'HomeSi.dart';

// ignore: must_be_immutable
class AgendarPage extends StatefulWidget {
  @override
  _AgendarPageState createState() => _AgendarPageState();
}

class _AgendarPageState extends State<AgendarPage> with RouteAware {
  Map<String, dynamic>? selectedAsesor;
  late ScrollController _scrollController;
  int currentIndex = 1;

  Future<List<Map<String, dynamic>>> fetchAsesores() async {
    final CollectionReference asesores =
        FirebaseFirestore.instance.collection('Asesores');
    final QuerySnapshot snapshot = await asesores.get();
    List<Map<String, dynamic>> asesoresList = [];
    for (var doc in snapshot.docs) {
      var asesorData = doc.data() as Map<String, dynamic>;
      // Assuming the dates are stored as a list in the 'Dates' field in each Asesor document
      List<String>? asesorDates = List<String>.from(asesorData['Dates'] ?? []);
      asesorData['Dates'] = asesorDates;
      asesoresList.add(asesorData);
    }
    return asesoresList;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Remove back arrow
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        title: Text('Agendar Hora', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeetingsPage()),
              );
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 4), //Space between text and icon
                Text('Reuniones'),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // Top section
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://cdn.britannica.com/85/205685-050-24677990/Ryan-Reynolds-2011.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedAsesor != null
                        ? '${selectedAsesor!['Nombre']} ${selectedAsesor!['Apellidos']}'
                        : 'Asesor',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    selectedAsesor != null
                        ? selectedAsesor!['Especialidad']
                        : 'Especializacion',
                  ),
                ],
              ),
            ),
            Divider(),
            // Middle section
            Expanded(
              flex: 2,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchAsesores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No Asesores found.');
                  } else {
                    final asesores = snapshot.data!;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        double widthPerItem = 150.0;
                        double spacing = 8.0;
                        int itemsPerRow =
                            (constraints.maxWidth / (widthPerItem + spacing))
                                .floor();

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: itemsPerRow,
                            childAspectRatio: 3,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                          ),
                          itemCount: asesores.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAsesor = asesores[index];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.grey,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${asesores[index]['Nombre']} ${asesores[index]['Apellidos']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
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
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: selectedAsesor != null
                            ? selectedAsesor!['Dates'].length
                            : 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(selectedAsesor!['Dates'][index]),
                          );
                        },
                      ),
                    ),
                  ),
                  // Button
                  ElevatedButton(
                    onPressed: () {
                      if (selectedAsesor != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PagCalendario(
                              nombre: selectedAsesor!['Nombre'],
                              apellidos: selectedAsesor!['Apellidos'],
                              correo: selectedAsesor!['Correo'],
                            ),
                          ),
                        );
                      } else {
                        // Optionally, show a message to the user to select an asesor first
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Por favor seleccione un Asesor')),
                        );
                      }
                    },
                    child: Text('Agendar Hora'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 32,
        selectedItemColor: Colors.purple,
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex, // Establece el índice actual
        onTap: (index) {
          // Verifica si el índice está dentro del rango válido
          if (index >= 0 && index < pages.length) {
            // Cambia de página al tocar un ícono en el BottomNavigationBar
            setState(() {
              currentIndex = index;
            });

            // Navega a la página correspondiente utilizando Navigator
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pages[currentIndex]),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Agendar'),
          BottomNavigationBarItem(icon: Icon(Icons.flutter_dash), label: 'Bot'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Foro'),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // User swiped back to this page, so we update the currentIndex
    setState(() {
      currentIndex = 1;
    });
  }
}

class PagCalendario extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String correo;

  PagCalendario(
      {required this.nombre, required this.apellidos, required this.correo});
  @override
  _PagCalendarioState createState() => _PagCalendarioState();
}

class _PagCalendarioState extends State<PagCalendario> {
  int currentIndex = 1;
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  Duration? _duration;
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );
  //Mapping so that it works for the Firestore Dates field
  final dayMapping = {
    'Lunes': DateTime.monday,
    'Martes': DateTime.tuesday,
    'Miércoles': DateTime.wednesday,
    'Jueves': DateTime.thursday,
    'Viernes': DateTime.friday,
  };
  //Check if another event is being stored at the same time and check for Asesor's availability
  Future<bool> isOverlapping(DateTime start, DateTime end) async {
    // Query for events that start before the end of the new event
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('reunion')
        .where('start', isLessThanOrEqualTo: end.toIso8601String())
        .get();

    // Query for events that end after the start of the new event
    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('reunion')
        .where('end', isGreaterThanOrEqualTo: start.toIso8601String())
        .get();

    // Combine the results of the two queries
    List<QueryDocumentSnapshot> combinedQuery = [];
    combinedQuery.addAll(querySnapshot1.docs);
    combinedQuery.addAll(querySnapshot2.docs);

    // Check if any of the combined results overlap with the new event
    for (var doc in combinedQuery) {
      DateTime eventStart = DateTime.parse(doc['start']);
      DateTime eventEnd = DateTime.parse(doc['end']);

      if ((start.isAfter(eventStart) && start.isBefore(eventEnd)) ||
          (end.isAfter(eventStart) && end.isBefore(eventEnd)) ||
          (start.isAtSameMomentAs(eventStart) &&
              end.isAtSameMomentAs(eventEnd)) ||
          (start.isAtSameMomentAs(eventStart) && end.isAfter(eventStart)) ||
          (start.isBefore(eventEnd) && end.isAtSameMomentAs(eventEnd))) {
        return true;
      }
    }

    // Check Asesor availability
    QuerySnapshot asesorAvailability = await FirebaseFirestore.instance
        .collection('Asesores')
        .where('Correo', isEqualTo: widget.correo)
        .get();

    if (asesorAvailability.docs.isEmpty) {
      // Check if there's no data about the Asesor's availability
      return true;
    }

    // Extract available dates
    List<String> availableDates =
        List.from(asesorAvailability.docs.first['Dates']);

    for (String range in availableDates) {
      final components =
          range.split(' '); // Split by space to get day and time range
      if (components.length != 2)
        continue; // Skip if format is not well written

      final dayName = components[0];
      final timeRange = components[1].split('-');

      if (timeRange.length != 2)
        continue; // Skip if time range format is not well written

      final dayNumber = dayMapping[dayName];
      if (dayNumber == null || dayNumber != start.weekday)
        continue; // Check if the day matches

      final startTimeComponents =
          timeRange[0].split(':').map((e) => int.parse(e)).toList();
      final endTimeComponents =
          timeRange[1].split(':').map((e) => int.parse(e)).toList();

      if (startTimeComponents.length != 2 || endTimeComponents.length != 2)
        continue;

      final rangeStart = DateTime(start.year, start.month, start.day,
          startTimeComponents[0], startTimeComponents[1]);
      final rangeEnd = DateTime(start.year, start.month, start.day,
          endTimeComponents[0], endTimeComponents[1]);

      if ((start.isAfter(rangeStart) && start.isBefore(rangeEnd)) ||
          (end.isAfter(rangeStart) && end.isBefore(rangeEnd)) ||
          start.isAtSameMomentAs(rangeStart) ||
          end.isAtSameMomentAs(rangeEnd) ||
          (start.isBefore(rangeEnd) && end.isAfter(rangeStart))) {
        return false;
      }
    }

    return true;
  }

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
              flex: 0,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Reunirse con ${widget.nombre} ${widget.apellidos}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Divider(),
            // Middle section
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _selectedDay ?? DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (selectedDay.isBefore(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'No puedes seleccionar un día pasado')),
                          );
                          return; // Do not update state if selected day is before today
                        }
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime ?? TimeOfDay.now(),
                        );
                        if (pickedTime != null && pickedTime != _selectedTime) {
                          setState(() {
                            _selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Text('Seleccionar Hora'),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            // Bottom section
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
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
                      _selectedDay != null && _selectedTime != null
                          ? 'Fecha seleccionada: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}\nHora de la reunión: ${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}\nDuración: ${_duration?.inHours ?? 0} horas y ${_duration?.inMinutes.remainder(60) ?? 0} minutos'
                          : 'No se ha seleccionado ninguna fecha',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            // Button
            ElevatedButton(
              onPressed: () async {
                if (_selectedDay == null ||
                    _selectedTime == null ||
                    _duration == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('No hay día u hora seleccionada'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                DateTime appointmentDateTime = DateTime(
                  _selectedDay!.year,
                  _selectedDay!.month,
                  _selectedDay!.day,
                  _selectedTime!.hour,
                  _selectedTime!.minute,
                );
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
                    ..dateTime = appointmentDateTime
                    ..timeZone = 'America/Santiago';
                  final end = gcal.EventDateTime()
                    ..dateTime = appointmentDateTime.add(_duration!)
                    ..timeZone = 'America/Santiago';
                  final calendar = gcal.CalendarApi(authenticatedClient);
                  final event = gcal.Event()
                    ..summary =
                        'Reunión con ${widget.nombre} ${widget.apellidos}'
                    ..start = start
                    ..end = end;

                  if (appointmentDateTime != null) {
                    bool isOverlap = await isOverlapping(appointmentDateTime!,
                        appointmentDateTime.add(_duration!));
                    if (!isOverlap) {
                      // Add the event to Firestore
                      event.attendees = [
                        gcal.EventAttendee(
                            email: widget
                                .correo), // Add the asesor's email as an attendee
                      ];
                      gcal.Event createdEvent =
                          await calendar.events.insert(event, 'primary');

                      // After successful insertion, add the event to Firestore
                      await firestore.collection('reunion').add({
                        'summary': createdEvent.summary,
                        'start': event.start!.dateTime!.toIso8601String(),
                        'end': event.end!.dateTime!.toIso8601String(),
                        'email': currentUser?.email,
                        'googleEventId': createdEvent
                            .id, // Use the ID from the created event
                      });

                      // Show a message that the event was created successfully
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Raunión agendada'),
                            content: Text('Hora reservada correctamente.'),
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
                    } else {
                      // Show a message that the event overlaps with an existing event
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(
                                'Hora ya reservada o asesor no disponible en ese horario.'),
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
                    }
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
