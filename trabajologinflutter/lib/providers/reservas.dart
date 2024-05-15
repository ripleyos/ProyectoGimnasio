class Reserva {
  final String idReserva;
  final String idMaquina;
  final String idGimnasio;
  final String intervalo;
  final String semana;
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