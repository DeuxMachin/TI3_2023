import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DropdownMenuItem<String> customDropdownItem(String value) {
  return DropdownMenuItem<String>(
    value: value,
    child: Column(
      children: <Widget>[
        Text(value),
        Divider(), // Divider line
      ],
    ),
  );
}

class AdminAsesoresPage extends StatefulWidget {
  @override
  _AdminAsesoresPageState createState() => _AdminAsesoresPageState();
}

class _AdminAsesoresPageState extends State<AdminAsesoresPage> {
  // TODO: Fetch data from Firebase and implement the UI
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asesores', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Asesores').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var asesores = snapshot.data!.docs;
          return ListView.builder(
            itemCount: asesores.length,
            itemBuilder: (context, index) {
              var asesor = asesores[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(asesor['Nombre']),
                subtitle: Text(asesor['Apellidos']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditAsesorWidget(
                              asesorData: asesor,
                              docId: asesores[index].id,
                              onUpdate: (updatedData) {
                                _firestore
                                    .collection('Asesores')
                                    .doc(asesores[index].id)
                                    .update(updatedData);
                              },
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmar Eliminación"),
                              content: Text(
                                  "¿Está seguro de que quiere eliminar al asesor?"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Eliminar"),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    _firestore
                                        .collection('Asesores')
                                        .doc(asesores[index].id)
                                        .delete();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CreateAsesorWidget(
                onCreate: (newAsesorData) {
                  _firestore.collection('Asesores').add(newAsesorData);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditAsesorWidget extends StatefulWidget {
  final Map<String, dynamic> asesorData;
  final String docId;
  final Function(Map<String, dynamic>) onUpdate;

  EditAsesorWidget(
      {required this.asesorData, required this.docId, required this.onUpdate});

  @override
  _EditAsesorWidgetState createState() => _EditAsesorWidgetState();
}

class _EditAsesorWidgetState extends State<EditAsesorWidget> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _correoController;
  late TextEditingController _datesController;
  String? _selectedEspecialidad;
  late TextEditingController _photoUrlController;

  final List<String> _especialidadOptions = [
    'Seguimiento y estudio y PID (Proyecto de Innovacion docente)',
    'Virtualización, asesoria docente y Impulsa tu RED',
    'Virtualización, comunidad de aprendizaje , asesoria docente, Formación docente',
    'Laboratorio Experimental - Realidades Extendidas',
    'Bienestar Docente, asesoria docente, comunidades de aprendizaje, Formación docente',
    'Gestión agenda Dirección , espacios y procesos CINAP',
  ];

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.asesorData['Nombre']);
    _apellidosController =
        TextEditingController(text: widget.asesorData['Apellidos']);
    _correoController =
        TextEditingController(text: widget.asesorData['Correo']);
    _datesController =
        TextEditingController(text: widget.asesorData['Dates'].join(", "));
    _selectedEspecialidad = widget.asesorData['Especialidad'];
    _photoUrlController =
        TextEditingController(text: widget.asesorData['photoUrl']);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _datesController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  DropdownMenuItem<String> customDropdownItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Column(
        children: <Widget>[
          Text(value),
          Divider(), // Divider line
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Asesor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _apellidosController,
              decoration: InputDecoration(labelText: 'Apellidos'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _datesController,
              decoration: InputDecoration(
                  labelText: 'Fechas (separadas por coma y recordar tildes))'),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: _selectedEspecialidad,
              decoration: InputDecoration(labelText: 'Especialidad'),
              items: _especialidadOptions.map((String value) {
                return customDropdownItem(value);
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedEspecialidad = newValue;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return _especialidadOptions.map<Widget>((String value) {
                  return Text(
                    value.length > 30
                        ? '${value.substring(0, 30)}...'
                        : value, // Truncating the text
                    overflow: TextOverflow.ellipsis,
                  );
                }).toList();
              },
            ),
            SizedBox(height: 8),
            TextField(
              controller: _photoUrlController,
              decoration: InputDecoration(labelText: 'URL de la Foto'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: () {
            Map<String, dynamic> updatedData = {
              'Nombre': _nombreController.text,
              'Apellidos': _apellidosController.text,
              'Correo': _correoController.text,
              'Dates': _datesController.text
                  .split(',')
                  .map((s) => s.trim())
                  .toList(),
              'Especialidad': _selectedEspecialidad,
              'photoUrl': _photoUrlController.text,
            };
            widget.onUpdate(updatedData);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class CreateAsesorWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreate;

  CreateAsesorWidget({required this.onCreate});

  @override
  _CreateAsesorWidgetState createState() => _CreateAsesorWidgetState();
}

class _CreateAsesorWidgetState extends State<CreateAsesorWidget> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _datesController = TextEditingController();
  String? _selectedEspecialidad;
  final TextEditingController _photoUrlController = TextEditingController();

  final List<String> _especialidadOptions = [
    'Seguimiento y estudio y PID (Proyecto de Innovacion docente)',
    'Virtualización, asesoria docente y Impulsa tu RED',
    'Virtualización, comunidad de aprendizaje , asesoria docente, Formación docente',
    'Laboratorio Experimental - Realidades Extendidas',
    'Bienestar Docente, asesoria docente, comunidades de aprendizaje, Formación docente',
    'Gestión agenda Dirección , espacios y procesos CINAP',
  ];

  DropdownMenuItem<String> customDropdownItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Column(
        children: <Widget>[
          Text(value),
          Divider(), // Divider line
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _datesController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Crear Asesor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _apellidosController,
              decoration: InputDecoration(labelText: 'Apellidos'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo',
                hintText: 'ejemplo@correo.com', // Placeholder for Correo
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _datesController,
              decoration: InputDecoration(
                labelText: 'Fechas (separadas por coma y recordar tildes)',
                hintText:
                    'Miércoles 08:00-18:00, Viernes 08:00-18:00', // Placeholder for Fechas
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: _selectedEspecialidad,
              decoration: InputDecoration(labelText: 'Especialidad'),
              items: _especialidadOptions.map((String value) {
                return customDropdownItem(value);
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedEspecialidad = newValue;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return _especialidadOptions.map<Widget>((String value) {
                  return Text(
                    value.length > 30
                        ? '${value.substring(0, 30)}...'
                        : value, // Truncating the text
                    overflow: TextOverflow.ellipsis,
                  );
                }).toList();
              },
            ),
            SizedBox(height: 8),
            TextField(
              controller: _photoUrlController,
              decoration: InputDecoration(labelText: 'URL de la Foto'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Crear'),
          onPressed: () {
            Map<String, dynamic> newAsesorData = {
              'Nombre': _nombreController.text,
              'Apellidos': _apellidosController.text,
              'Correo': _correoController.text,
              'Dates': _datesController.text
                  .split(',')
                  .map((s) => s.trim())
                  .toList(),
              'Especialidad': _selectedEspecialidad,
              'photoUrl': _photoUrlController.text,
            };
            widget.onCreate(newAsesorData);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
