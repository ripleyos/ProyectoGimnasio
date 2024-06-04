class Cliente {
  String id;
  String nombre;
  String correo;
  String imagenUrl;
  String peso;
  String kcalMensual;
  String estrellas;
  List<String> amigos;
  List<String> amigosPendientes;
  String objetivomensual;
  String idgimnasio;
  String altura;

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

  factory Cliente.fromJson(String key, Map<String, dynamic> json) {
    return Cliente(
      id: key,
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
  void actualizarImagenUrl(String nuevaImagenUrl) {
    imagenUrl = nuevaImagenUrl;
  }
}
