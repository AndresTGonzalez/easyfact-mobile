class VisualDetalleFactura {
  int? idDetalle;
  String producto;
  int cantidad;
  double precio;
  double? iva;

  VisualDetalleFactura({
    this.iva,
    this.idDetalle,
    required this.producto,
    required this.cantidad,
    required this.precio,
  });
}
