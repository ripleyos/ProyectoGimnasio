class Gimnasio {
  final String id;
  final String nombre;
  final String descripcion;
  final String latitud;
  final String longitud;
  final String contra;

  Gimnasio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.contra,
  });

  factory Gimnasio.fromJson(Map<String, dynamic> json) {
    return Gimnasio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      contra: json['contra'],
    );
  }
}
