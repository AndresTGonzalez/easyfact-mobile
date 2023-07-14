class Factura {
  int? numeroFactura;
  int? idDocumentoPer;
  int? idFormaPagoPer;
  int? idUsuarioPer;
  String? idClientePer;
  int? idFactura;
  String? claveAcceso;
  DateTime? fecha;
  double? subtotal;
  double? totalIva;
  double? total;
  String? estado;

  Factura({
    required this.numeroFactura,
    required this.idDocumentoPer,
    required this.idFormaPagoPer,
    required this.idUsuarioPer,
    required this.idClientePer,
    required this.idFactura,
    required this.claveAcceso,
    required this.fecha,
    required this.subtotal,
    required this.totalIva,
    required this.total,
    this.estado,
  });

  Factura.fromJson(Map<String, dynamic> json) {
    numeroFactura = json['numero_factura'];
    idDocumentoPer = json['id_documento_per'];
    idFormaPagoPer = json['id_forma_pago_per'];
    idUsuarioPer = json['id_usuario_per'];
    idClientePer = json['id_cliente_per'];
    idFactura = json['id_factura'];
    claveAcceso = json['clave_acceso'];
    fecha = DateTime.parse(json['fecha']);
    subtotal = double.parse(json['subtotal']);
    totalIva = double.parse(json['total_iva']);
    total = double.parse(json['total']);
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numero_factura'] = numeroFactura;
    data['id_documento_per'] = idDocumentoPer;
    data['id_forma_pago_per'] = idFormaPagoPer;
    data['id_usuario_per'] = idUsuarioPer;
    data['id_cliente_per'] = idClientePer;
    data['id_factura'] = idFactura;
    data['clave_acceso'] = claveAcceso;
    data['fecha'] = fecha?.toIso8601String();
    data['subtotal'] = subtotal?.toStringAsFixed(2);
    data['total_iva'] = totalIva?.toStringAsFixed(2);
    data['total'] = total?.toStringAsFixed(2);
    data['estado'] = estado;
    return {
      'Facturas': [data]
    };
  }

  Factura copy() {
    return Factura(
      numeroFactura: numeroFactura,
      idDocumentoPer: idDocumentoPer,
      idFormaPagoPer: idFormaPagoPer,
      idUsuarioPer: idUsuarioPer,
      idClientePer: idClientePer,
      idFactura: idFactura,
      claveAcceso: claveAcceso,
      fecha: fecha,
      subtotal: subtotal,
      totalIva: totalIva,
      total: total,
      estado: estado,
    );
  }
}
