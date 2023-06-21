class Linea {
  late String codigo;
  late String descripcion;
  late double cantidad;
  late double importe;
  late double precio;

  Linea(
      {required this.codigo,
      required this.descripcion,
      required this.cantidad,
      required this.importe,
      required this.precio});

  Linea.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] ?? "";
    descripcion = json['descripcion'] ?? '';
    cantidad = json['cantidad'] ?? 0.0;
    precio = json['precio'] ?? 0.0;
    importe = json['importe'] ?? 0.0;
  }
}
