class User {
  final int id;
  final String nombre;
  final String correo;
  final String rol;
  final int? tiendaId;
  final bool verificado;
  final DateTime? creadoEn;

  User({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
    this.tiendaId,
    required this.verificado,
    this.creadoEn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      rol: json['rol'],
      tiendaId: json['tienda_id'],
      verificado: json['verificado'],
      creadoEn: json['creado_en'] != null ? DateTime.tryParse(json['creado_en']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'rol': rol,
      'tienda_id': tiendaId,
      'verificado': verificado,
      'creado_en': creadoEn?.toIso8601String(),
    };
  }
}
