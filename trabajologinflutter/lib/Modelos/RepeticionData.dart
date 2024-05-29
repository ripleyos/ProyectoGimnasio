class RepeticionData {
  String? maquinaSeleccion;
  String? idMaquinaSeleccionada;
  String? fechaSeleccionada;
  String? intervaloSeleccion;
  String? diaSeleccion;
  List<String> maquinasMostrar;
  Map<String, String> nombreToIdMaquina;
  List<String> filteredOptions;
  String? localizacionMaquina;
  String? marcaMaquina;

  RepeticionData({
    required this.maquinasMostrar,
    required this.nombreToIdMaquina,
    required this.filteredOptions,
  });
}