class Producto {
  int idIvaPer;
  int idProducto;
  String producto;
  double precio;

  Producto({
    required this.idIvaPer,
    required this.idProducto,
    required this.producto,
    required this.precio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idIvaPer: json['id_iva_per'],
      idProducto: json['id_producto'],
      producto: json['producto'],
      precio: double.parse(json['precio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_iva_per': idIvaPer,
      'id_producto': idProducto,
      'producto': producto,
      'precio': precio.toString(),
    };
  }

  Producto copy() {
    return Producto(
      idIvaPer: idIvaPer,
      idProducto: idProducto,
      producto: producto,
      precio: precio,
    );
  }
}
