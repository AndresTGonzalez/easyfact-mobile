import 'package:easyfact_mobile/models/producto.dart';
import 'package:flutter/material.dart';

class InvoiceDetailService extends ChangeNotifier {
  Producto selectedProduct =
      Producto(idIvaPer: 0, idProducto: 0, producto: '', precio: 0);
  int cantidad = 1;

  final List<Producto> products = [];

  void setSelectedProduct(Producto producto) {
    selectedProduct = producto;
    notifyListeners();
  }
}
