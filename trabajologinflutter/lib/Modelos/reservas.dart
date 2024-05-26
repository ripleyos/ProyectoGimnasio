class Reserva {
  String id;
  String fecha;
  String idCliente;
  String idGimnasio;
  String idMaquina;
  String intervalo;

  Reserva({
    required this.id,
    required this.fecha,
    required this.idCliente,
    required this.idGimnasio,
    required this.idMaquina,
    required this.intervalo,
  });

  factory Reserva.fromJson(String id, Map<String, dynamic> json) {
    return Reserva(
      id: id,
      fecha: json['fecha'],
      idCliente: json['id_cliente'],
      idGimnasio: json['id_gimnasio'],
      idMaquina: json['id_maquina'],
      intervalo: json['intervalo'],
    );
  }
}
