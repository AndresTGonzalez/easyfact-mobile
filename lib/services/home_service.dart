import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  final int probar = 0;

  HomeService() {
    loadCardsInfo();
  }

  Future loadCardsInfo() async {
    final url = Uri.http(_baseUrl, '/api/productoestrella/1/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error en la solicitud GET');
    }
  }
}
