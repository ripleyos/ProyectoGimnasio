class Cliente {
  final String id;
  late final String nombre;
  final String correo;
  late final String imagenUrl;
  final String peso;
  final String kcalMensual;
  final String estrellas;
  final List<String> amigos;
  final List<String> amigosPendientes;
  final String objetivomensual;
  final String idgimnasio;
  final String altura;

  Cliente({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.imagenUrl,
    required this.peso,
    required this.kcalMensual,
    required this.estrellas,
    required this.amigos,
    required this.amigosPendientes,
    required this.objetivomensual,
    required this.idgimnasio,
    required this.altura,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] != null ? json['id'] as String : '',
      nombre: json['nombre'] != null ? json['nombre'] as String : '',
      correo: json['correo'] != null ? json['correo'] as String : '',
      imagenUrl: json['imagenUrl'] != null ? json['imagenUrl'] as String : '',
      peso: json['peso'] != null ? json['peso'] as String : '',
      kcalMensual: json['kcalMensual'] != null ? json['kcalMensual'] as String : '',
      estrellas: json['estrellas'] != null ? json['estrellas'] as String : '',
      amigos: json['amigos'] != null ? List<String>.from(json['amigos'] as List) : [],
      amigosPendientes: json['amigos_pendientes'] != null ? List<String>.from(json['amigos_pendientes'] as List) : [],
      objetivomensual: json['objetivomensual'] != null ? json['objetivomensual'] as String : '',
      idgimnasio: json['idgimnasio'] != null ? json['idgimnasio'] as String : '',
      altura: json['altura'] != null ? json['altura'] as String : '',
    );
  }
}
