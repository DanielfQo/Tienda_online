class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final int? tiendaId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.tiendaId,
  });
}
