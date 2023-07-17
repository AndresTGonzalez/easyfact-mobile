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
  double total = 0;
  double iva = 0;
  final List<VisualDetalleFactura> detalles = [];

  void setSelectedProduct(Producto producto) {
    selectedProduct = producto;
    notifyListeners();
  }

  Future deleteByProduct(int id) async {
    int index = getIndexById(id);
    final url = Uri.http(_baseUrl, '/api/agregarproducto/$id/');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      double subtotalProducto =
          detalles[index].precio * detalles[index].cantidad;
      total -= subtotalProducto;
      iva -= detalles[index].iva!;
      detalles.removeAt(index);
      notifyListeners();
    } else {
      // throw Exception('Error en la solicitud POST');
      print('Error en la solicitud DELETE');
      print(response.body);
    }
  }

  int getIndexById(int id) {
    return detalles.indexWhere((element) => element.idDetalle == id);
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
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      int idDetalle = jsonData['Detalle']['id_detalle_factura'];
      double ivaProducto = double.parse(jsonData['Detalle']['total_iva']);
      detalles.add(VisualDetalleFactura(
        idDetalle: idDetalle,
        producto: selectedProduct.producto,
        cantidad: cantidad,
        precio: selectedProduct.precio,
        iva: ivaProducto,
      ));
      cantidad = 1;

      double subtotalProducto =
          double.parse(jsonData['Detalle']['subtotal_producto']);

      total += subtotalProducto;
      iva += ivaProducto;
      notifyListeners();
    } else {
      // throw Exception('Error en la solicitud POST');
      print('Error en la solicitud POST');
      print(response.body);
    }
  }

  void resetSumary() {
    total = 0;
    iva = 0;
    detalles.clear();
    notifyListeners();
  }
}
