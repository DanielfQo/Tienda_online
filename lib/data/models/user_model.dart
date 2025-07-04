import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.nombre,
    required super.correo,
    required super.rol,
    super.tiendaId,
    required super.verificado,
    super.creadoEn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      rol: json['rol'],
      tiendaId: json['tienda_id'],
      verificado: json['verificado'],
      creadoEn: json['creado_en'] != null ? DateTime.tryParse(json['creado_en']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'correo': correo,
        'rol': rol,
        'tienda_id': tiendaId,
        'verificado': verificado,
        'creado_en': creadoEn?.toIso8601String(),
      };
}
