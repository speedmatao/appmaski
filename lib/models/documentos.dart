import 'package:intl/intl.dart';

class Documento {
  late int id;
  late String documento;
  late String fecha;
  late double importe;
  late String estado;

  Documento(
      {required this.id,
      required this.documento,
      required this.fecha,
      required this.importe,
      required this.estado});

  Documento.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    documento = json['documento'] ?? '';
    fecha = DateFormat('dd/MM/yyyy').format(DateTime.parse(json['fecha']));
    importe = json['importe'] ?? 0.0;
    estado = json['estado'] ?? '';
  }
}
