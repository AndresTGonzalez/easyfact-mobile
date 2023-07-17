import 'dart:convert';

import 'package:easyfact_mobile/models/iva.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class IvaService extends ChangeNotifier {
  final List<Iva> categorias = [];

  static const String _baseUrl = '34.75.222.189:8000';

  late String? iva;
  late double? porcentaje;

  final storage = FlutterSecureStorage();
  late final int idEmpresa;

  IvaService() {
    loadIva();
  }

  loadIva() async {
    String? empresa = await storage.read(key: 'idEmpresa');
    int? idEmpresa = int.parse(empresa!);
    final url = Uri.http(_baseUrl, '/api/iva/$idEmpresa/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = jsonDecode(response.body);
      final ivaData = jsonData['ivas'] as List<dynamic>;

      final iva = ivaData.map((ivaData) {
        return Iva(
          idIva: ivaData['id_iva'],
          ivaNombre: ivaData['iva_nombre'],
          iva: ivaData['iva'],
        );
      }).toList();
      categorias.addAll(iva);
      notifyListeners();
    } else {
      throw Exception('Error al cargar los IVA');
    }
  }
}
