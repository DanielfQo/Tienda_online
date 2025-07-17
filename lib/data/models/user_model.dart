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
    super.fechaNacimiento,
    super.genero,
    super.foto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['name'], // asegúrate que coincide con tu API
      correo: json['email'],
      rol: json['role'],
      tiendaId: json['store_id'],
      verificado: json['verified'],
      creadoEn: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      fechaNacimiento: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      genero: json['gender'],
      foto: json['photo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': nombre,
    'email': correo,
    'role': rol,
    'store_id': tiendaId,
    'verified': verificado,
    'created_at': creadoEn?.toIso8601String(),
    'birth_date': fechaNacimiento?.toIso8601String(),
    'gender': genero,
    'photo': foto,
  };
}
