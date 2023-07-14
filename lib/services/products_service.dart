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
    final response = await http.post(url, body: {
      'id_iva_per': product.idIvaPer.toString(),
      'producto': product.producto,
      'precio': product.precio.toString(),
    });
    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(response.body);
      // final productData = jsonData['producto'];
      // final newProduct = Producto(
      //     idIvaPer: productData['id_iva_per'],
      //     producto: productData['producto'],
      //     precio: double.parse(productData['precio']),
      //     idProducto: productData['id_producto']);
      // products.add(newProduct);
      print(response.body);
      notifyListeners();
    } else {
      throw Exception('Error al crear el producto');
    }
  }
}
