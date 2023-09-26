import 'package:flutter/material.dart';

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

class PagCalendario extends StatelessWidget {
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
                  child: Text(
                    'Aqui va el calendario',
                    style: TextStyle(fontSize: 24),
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
                    'Cuanto tiempo necesitara?',
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('15 minutos'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('30 minutos'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('1 hora'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 11, // 11 hours from 08:00 to 18:00
                      itemBuilder: (context, index) {
                        final hour = index + 8;
                        return ListTile(
                          title: Text('$hour:00'),
                          onTap: () {
                            // Handle hour selection
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            // Button
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('Agendar Hora'),
            ),
          ],
        ),
      ),
    );
  }
}
