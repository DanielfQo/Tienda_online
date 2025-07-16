class User {
  final int id;
  final String nombre;
  final String correo;
  final String rol;
  final int? tiendaId;
  final bool verificado;
  final DateTime? creadoEn;
  final DateTime? fechaNacimiento;
  final String? genero;
  final String? foto;

  User({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
    this.tiendaId,
    required this.verificado,
    this.creadoEn,
    this.fechaNacimiento,
    this.genero,
    this.foto,
  });
}
