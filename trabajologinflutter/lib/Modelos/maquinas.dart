class Maquina {
  final String idMaquina;
  final String idGimnasio;
  final String localizacion;
  final String marca;
  final String nombre;
  final String tipo;
  

  Maquina({
    required this.idMaquina,
    required this.idGimnasio,
    required this.localizacion,
    required this.marca,
    required this.nombre,
    required this.tipo,
  });

  factory Maquina.fromJson(Map<String, dynamic> json) {
    return Maquina(
      idMaquina: json['id_maquina'] ?? 0,
      idGimnasio: json['id_gimnasio'] ?? 0,
      localizacion: json['localizacion'] ?? 0,
      marca: json['marca'] ?? '',
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
    );
  }
}
