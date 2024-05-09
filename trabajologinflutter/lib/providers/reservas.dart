class Reserva {
  final int idReserva;
  final int idMaquina;
  final int idGimnasio;
  final String horaInicio;
  final String horaFin;

  Reserva({
    required this.idReserva,
    required this.idMaquina,
    required this.idGimnasio,
    required this.horaInicio,
    required this.horaFin,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      idReserva: json['id_reserva'],
      idMaquina: json['id_maquina'],
      idGimnasio: json['id_gimnasio'],
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
    );
  }
}