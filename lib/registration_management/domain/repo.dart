class Alumno {
  final String nombre;
  final String apellido;
  final String documento;
  final String numeroLegajo;
  final String carrera;
  bool fotocopiaDocumento;
  bool fotoCarnet;
  bool psicofisico;
  bool fotocopiaPartidaNacimiento;
  bool tituloSecundario;
  bool cetificadoVacunacion;

  Alumno({
    required this.nombre,
    required this.apellido,
    required this.documento,
    required this.numeroLegajo,
    required this.carrera,
    this.fotocopiaDocumento = false,
    this.fotoCarnet = false,
    this.psicofisico = false,
    this.fotocopiaPartidaNacimiento = false,
    this.tituloSecundario = false,
    this.cetificadoVacunacion = false,
  });
}

class AlumnoRepository {
  final List<Alumno> alumnos;

  AlumnoRepository(this.alumnos);
}

List<Alumno> generateAlumnos() {
  return [
    Alumno(
      nombre: 'Juan',
      apellido: 'Pérez',
      documento: '12345678',
      numeroLegajo: 'A123',
      carrera: 'Ingeniería Informática',
      fotocopiaDocumento: false,
      fotoCarnet: true,
      psicofisico: false,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: true,
    ),
    Alumno(
      nombre: 'María',
      apellido: 'Gómez',
      documento: '98765432',
      numeroLegajo: 'B456',
      carrera: 'Medicina',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: true,
    ),
    Alumno(
      nombre: 'Carlos',
      apellido: 'López',
      documento: '56781234',
      numeroLegajo: 'C789',
      carrera: 'Derecho',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: false,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: true,
    ),
    Alumno(
      nombre: 'Laura',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
    Alumno(
      nombre: 'LaurawwSSS',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
    Alumno(
      nombre: 'Lauddra',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
    Alumno(
      nombre: 'ddLauraSSS',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
    Alumno(
      nombre: 'Laurad',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
    Alumno(
      nombre: 'LauraddSSS',
      apellido: 'Martínez',
      documento: '34567812',
      numeroLegajo: 'D012',
      carrera: 'Arquitectura',
      fotocopiaDocumento: true,
      fotoCarnet: true,
      psicofisico: true,
      fotocopiaPartidaNacimiento: true,
      tituloSecundario: true,
      cetificadoVacunacion: false,
    ),
  ];
}
