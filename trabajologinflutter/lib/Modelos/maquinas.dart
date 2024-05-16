class Machine {
  final int idMaquina;
  final int metIntenso;
  final int metIntermedio;
  final int metLigero;
  final String marca;
  final String nombre;
  final String tipo;

  Machine({
    required this.idMaquina,
    required this.metIntenso,
    required this.metIntermedio,
    required this.metLigero,
    required this.marca,
    required this.nombre,
    required this.tipo,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      idMaquina: json['id_maquina'] ?? 0,
      metIntenso: json['MET_intenso'] ?? 0,
      metIntermedio: json['MET_intermedio'] ?? 0,
      metLigero: json['MET_ligero'] ?? 0,
      marca: json['marca'] ?? '',
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
    );
  }
}
