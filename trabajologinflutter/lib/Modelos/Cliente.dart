class Cliente {
  final String correo;
  final String id;
  final String nombre;
  final String peso;
  final String? telefono;

  Cliente({
    required this.correo,
    required this.id,
    required this.nombre,
    required this.peso,
    this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      correo: json['correo'],
      id: json['id'],
      nombre: json['nombre'],
      peso: json['peso'],
      telefono: json['telefono'],
    );
  }
}
