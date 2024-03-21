import 'package:flutter/material.dart';
import 'package:sistema_ies/registration_management/presentation/widgets/background.dart';
import 'package:sistema_ies/registration_management/presentation/widgets/titlewidgets.dart';

import '../domain/repo.dart';

void main() => runApp(const RegistrationManagement());

class RegistrationManagement extends StatelessWidget {
  const RegistrationManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Alumno> alumnos = generateAlumnos();
    final AlumnoRepository repo = AlumnoRepository(alumnos);
    return MaterialApp(
      home: MainScreen(alumnoRepository: repo),
    );
  }
}

class MainScreen extends StatelessWidget {
  final AlumnoRepository alumnoRepository;

  const MainScreen({Key? key, required this.alumnoRepository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlumnoSearch(alumnoRepository: alumnoRepository),
    );
  }
}

class AlumnoSearch extends StatefulWidget {
  final AlumnoRepository alumnoRepository;
  const AlumnoSearch({Key? key, required this.alumnoRepository})
      : super(key: key);

  @override
  AlumnoSearchState createState() => AlumnoSearchState();
}

class AlumnoSearchState extends State<AlumnoSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<Alumno> _searchResults = [];
  int _selectedAlumnoIndex = -1;

  void _searchAlumnos(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = widget.alumnoRepository.alumnos.where((alumno) {
          return alumno.nombre.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _selectedAlumnoIndex = -1;
    });
  }

  void _showAlumnosDetails(BuildContext context, int index) {
    setState(() {
      _selectedAlumnoIndex = index;
    });

    final alumno = _searchResults[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade200.withOpacity(0.8),
          title: const Text('Documentación Entregada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Fotocopia de Documento'),
                value: alumno.fotocopiaDocumento,
                onChanged: (value) {
                  setState(() {
                    alumno.fotocopiaDocumento = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Foto Carnet'),
                value: alumno.fotoCarnet,
                onChanged: (value) {
                  setState(() {
                    alumno.fotoCarnet = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Psicofisico'),
                value: alumno.psicofisico,
                onChanged: (value) {
                  setState(() {
                    alumno.psicofisico = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Certificado de Vacunación'),
                value: alumno.cetificadoVacunacion,
                onChanged: (value) {
                  setState(() {
                    alumno.cetificadoVacunacion = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Partida de Nacimiento'),
                value: alumno.fotocopiaPartidaNacimiento,
                onChanged: (value) {
                  setState(() {
                    alumno.fotocopiaPartidaNacimiento = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Título Secundario'),
                value: alumno.tituloSecundario,
                onChanged: (value) {
                  setState(() {
                    alumno.tituloSecundario = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tittlewidget(context),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  color: Colors.blue.shade200.withOpacity(0.6),
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 0,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del Alumno'),
                  onChanged: _searchAlumnos,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final alumno = _searchResults[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        left: 20,
                        right: 20,
                        bottom: 0,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedAlumnoIndex == index
                            ? Colors.blue.shade400.withOpacity(0.8)
                            : Colors.blue.shade200.withOpacity(0.8),
                      ),
                      child: ListTile(
                        title: Text("${alumno.nombre} ${alumno.apellido}"),
                        subtitle: Text(
                          'Documento: ${alumno.documento} Carrera: ${alumno.carrera}',
                        ),
                        onTap: () => _showAlumnosDetails(context, index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
