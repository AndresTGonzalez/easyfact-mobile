import 'dart:convert';

import 'package:easyfact_mobile/models/producto.dart';
import 'package:easyfact_mobile/models/visual_detalle_factura.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvoiceDetailService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  Producto selectedProduct = Producto(
    idIvaPer: 0,
    idProducto: 0,
    producto: '',
    precio: 0,
  );
  int cantidad = 1;
  final List<VisualDetalleFactura> detalles = [];

  void setSelectedProduct(Producto producto) {
    selectedProduct = producto;
    notifyListeners();
  }

  Future addDetalle(int idFactura) async {
    final url = Uri.http(_baseUrl, '/api/agregarproducto/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'id_factura_per': idFactura,
      'id_producto_per': selectedProduct.idProducto,
      'cantidad': cantidad,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      detalles.add(VisualDetalleFactura(
        producto: selectedProduct.producto,
        cantidad: cantidad,
        precio: selectedProduct.precio,
      ));
      cantidad = 1;
      print(body);
      print(response.body);
      notifyListeners();
    } else {
      // throw Exception('Error en la solicitud POST');
      print('Error en la solicitud POST');
      print(response.body);
    }
  }

  void printLength() {
    print(detalles.length);
  }
}
