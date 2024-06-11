class Gimnasio {
  final String id;
  final String nombre;
  final String descripcion;
  final String latitud;
  final String longitud;

  Gimnasio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
  });

  factory Gimnasio.fromJson(Map<String, dynamic> json) {
    return Gimnasio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      latitud: json['latitud'],
      longitud: json['longitud'],
    );
  }
}
