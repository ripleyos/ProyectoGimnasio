class Mensaje {
  final String remitente;
  final String destinatario;
  final String contenido;
  final DateTime marcaTiempo;

  Mensaje({
    required this.remitente,
    required this.destinatario,
    required this.contenido,
    required this.marcaTiempo,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
      remitente: json['remitente'] ?? '',
      destinatario: json['destinatario'] ?? '',
      contenido: json['contenido'] ?? '',
      marcaTiempo: DateTime.parse(json['marcaTiempo'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remitente': remitente,
      'destinatario': destinatario,
      'contenido': contenido,
      'marcaTiempo': marcaTiempo.toIso8601String(),
    };
  }
}
