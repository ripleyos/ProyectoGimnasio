class Reserva {
  final int idReserva;
  final int idMaquina;
  final int idGimnasio;
  final String intervalo;
  final int semana;
  final String dia;

  Reserva({
    required this.idReserva,
    required this.idMaquina,
    required this.idGimnasio,
    required this.intervalo,
    required this.semana,
    required this.dia,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      idReserva: json['id_reserva'] ?? '',
      idMaquina: json['id_maquina'] ?? '',
      idGimnasio: json['id_gimnasio'] ?? '',
      intervalo: json['intervalo'] ?? '',
      semana: json['semana'] ?? '',
      dia: json['dia'] ?? '',
    );
  }
}