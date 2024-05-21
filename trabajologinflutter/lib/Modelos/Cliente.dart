class Cliente {
  final String id;
  final String nombre;
  final String correo;
  final String imagenUrl;
  final String peso;
  final String kcalMensual;
  final String estrellas;

  Cliente({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.imagenUrl,
    required this.peso,
    required this.kcalMensual,
    required this.estrellas,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      imagenUrl: json['imagenUrl'] as String,
      peso: json['peso'] as String,
      kcalMensual: json['kcalMensual'] as String,
      estrellas: json['estrellas'] as String,
    );
  }
}
