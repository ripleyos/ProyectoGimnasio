class Cliente {
  final String id;
  final String nombre;
  final String correo;
  final String imagenUrl;
  final String peso;
  final String kcalMensual;
  final String estrellas;
  final List<String> amigos;
  final String objetivomensual;
  final String idgimnasio;

  Cliente({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.imagenUrl,
    required this.peso,
    required this.kcalMensual,
    required this.estrellas,
    required this.amigos,
    required this.objetivomensual,
    required this.idgimnasio,
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
      amigos: json['amigos'] != null ? List<String>.from(json['amigos'] as List) : [],
      objetivomensual: json['objetivomensual'] as String,
      idgimnasio: json['idgimnasio'] as String,
    );
  }
}
