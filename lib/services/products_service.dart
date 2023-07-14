import 'dart:convert';

import 'package:easyfact_mobile/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  final List<Producto> products = [];
  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/producto/1/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final productsData = jsonData['productos'] as List<dynamic>;

      final products = productsData.map((productData) {
        return Producto(
            idIvaPer: productData['id_iva_per'],
            producto: productData['producto'],
            precio: double.parse(productData['precio']),
            idProducto: productData['id_producto']);
      }).toList();
      this.products.addAll(products);
    } else {
      throw Exception('Error al cargar los clientes');
    }
  }

  Future createProduct(Producto product) async {
    final url = Uri.http(_baseUrl, '/api/producto/1/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(product.toJson());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error en la solicitud POST');
    }
  }

  Future editProduct(Producto product) async {
    final url = Uri.http(_baseUrl, '/api/producto/1/${product.idProducto}/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(product.toJson());
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error en la solicitud PUT');
    }
  }

  Future deleteProduct({required int idProducto}) async {
    final url = Uri.http(_baseUrl, '/api/producto/1/$idProducto/');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      products.removeAt(indexOfProduct(idProducto));
      notifyListeners();
    } else {
      throw Exception('Error en la solicitud DELETE');
    }
  }

  int indexOfProduct(int? idProducto) {
    return products.indexWhere((product) => product.idProducto == idProducto);
  }
}
