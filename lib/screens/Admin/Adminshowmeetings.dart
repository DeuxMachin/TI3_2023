import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminMeetingsPage extends StatefulWidget {
  @override
  _AdminMeetingsPageState createState() => _AdminMeetingsPageState();
}

class _AdminMeetingsPageState extends State<AdminMeetingsPage> {
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

  Future<void> getMeetings() async {
    final firestore = FirebaseFirestore.instance;
    final userMeetings = await firestore.collection('reunion').get();

    meetings = userMeetings.docs
        .map((doc) => {
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            })
        .toList();

    setState(() {});
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    bool confirm = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación'),
          content: Text('¿Está seguro de que desea eliminar esta reunión?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                confirm = false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return confirm;
  }

  Future<void> deleteMeeting(Map<String, dynamic> meeting) async {
    await deleteFromFirestore(meeting['id']);
    showDeletionDialog(context);
  }

  Future<void> deleteFromFirestore(String meetingId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('reunion').doc(meetingId).delete();
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
            title: Text('${meeting['email']} - ${meeting['summary']}'),
            subtitle: Text('$formattedDateStart - $formattedDateEnd'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    await editMeeting(meeting);
                    getMeetings();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    bool confirmDelete =
                        await showDeleteConfirmationDialog(context);
                    if (confirmDelete) {
                      await deleteMeeting(meeting);
                      getMeetings();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reunión cancelada'),
          content: Text('La reunión se ha eliminado correctamente.'),
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

  Future<void> editMeeting(Map<String, dynamic> meeting) async {
    DateTime? selectedDateStart = DateTime.parse(meeting['start']);
    DateTime? selectedDateEnd = DateTime.parse(meeting['end']);
    TimeOfDay? selectedStartTime = TimeOfDay.fromDateTime(selectedDateStart);
    TimeOfDay? selectedEndTime = TimeOfDay.fromDateTime(selectedDateEnd);

    // Function to update date
    Future<void> _pickDate(BuildContext context, StateSetter setState) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDateStart ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      if (pickedDate != null && pickedDate != selectedDateStart) {
        setState(() => selectedDateStart = pickedDate);
      }
    }

    // Function to update time from start to end
    Future<void> _pickStartTime(
        BuildContext context, StateSetter setState) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedStartTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null && pickedTime != selectedStartTime) {
        setState(() => selectedStartTime = pickedTime);
      }
    }

    Future<void> _pickEndTime(
        BuildContext context, StateSetter setState) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedEndTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null && pickedTime != selectedEndTime) {
        setState(() => selectedEndTime = pickedTime);
      }
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Editar Reunión'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Selecciona Fecha'),
                    subtitle: Text(
                        DateFormat('yyyy-MM-dd').format(selectedDateStart!)),
                    onTap: () => _pickDate(context, setState),
                  ),
                  ListTile(
                    title: Text('Selecciona Hora de Inicio'),
                    subtitle: Text(selectedStartTime?.format(context) ??
                        'No se ha elegido hora'),
                    onTap: () => _pickStartTime(context, setState),
                  ),
                  ListTile(
                    title: Text('Selecciona Hora de Término'),
                    subtitle: Text(selectedEndTime?.format(context) ??
                        'No se ha elegido hora'),
                    onTap: () => _pickEndTime(context, setState),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Actualizar'),
                  onPressed: () {
                    DateTime updatedDateTime = DateTime(
                      selectedDateStart!.year,
                      selectedDateStart!.month,
                      selectedDateStart!.day,
                      selectedStartTime!.hour,
                      selectedStartTime!.minute,
                    );
                    DateTime updatedEndDateTime = DateTime(
                      selectedDateEnd.year,
                      selectedDateEnd.month,
                      selectedDateEnd.day,
                      selectedEndTime!.hour,
                      selectedEndTime!.minute,
                    );
                    updateMeetingInFirestore(
                        meeting['id'], updatedDateTime, updatedEndDateTime);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> updateMeetingInFirestore(String meetingId,
      DateTime updatedDateTime, DateTime updatedEndDateTime) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('reunion').doc(meetingId).update({
      'start': updatedDateTime.toIso8601String(),
      'end': updatedEndDateTime.toIso8601String(),
    });
    showEditDialog(context);
  }

  // Show deletion dialog
  void showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reunión Editada'),
          content: Text('La reunión ha sido actualizada correctamente.'),
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
