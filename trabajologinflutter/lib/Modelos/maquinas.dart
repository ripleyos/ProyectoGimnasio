class Maquina {
  final String idMaquina;
  final String met;
  final String marca;
  final String nombre;
  final String tipo;

  Maquina({
    required this.idMaquina,
    required this.met,
    required this.marca,
    required this.nombre,
    required this.tipo,
  });

  factory Maquina.fromJson(Map<String, dynamic> json) {
    return Maquina(
      idMaquina: json['id_maquina'] ?? 0,
      met: json['met'] ?? 0,
      marca: json['marca'] ?? '',
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
    );
  }
}
