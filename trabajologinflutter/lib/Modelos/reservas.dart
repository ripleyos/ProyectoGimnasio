class Reserva {
  final String idReserva;
  final String idMaquina;
  final String idGimnasio;
  final String idCliente;
  final String intervalo;
  final String fecha;


  Reserva({
    required this.idReserva,
    required this.idMaquina,
    required this.idGimnasio,
    required this.idCliente,
    required this.intervalo,
    required this.fecha,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      idReserva: json['id_reserva'] ?? '',
      idMaquina: json['id_maquina'] ?? '',
      idGimnasio: json['id_gimnasio'] ?? '',
      idCliente: json['id_cliente'],
      intervalo: json['intervalo'] ?? '',
      fecha: json['fecha'] ?? '',
    );
  }
}