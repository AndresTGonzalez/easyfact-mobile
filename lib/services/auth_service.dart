import 'dart:convert';

import 'package:easyfact_mobile/global/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String _baseURL = 'http://34.75.222.189:8000/api/usuario';

  static Future<bool> login(String email, String password) async {
    var url = Uri.parse('$_baseURL/$email/$password');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        var jsonResponse = jsonDecode(response.body);
        var nombre = jsonResponse['usuario']['nombre'];
        var apellido = jsonResponse['usuario']['apellido'];
        var idUsuario = jsonResponse['usuario']['id_usuario'];
        var idEmpresa = jsonResponse['usuario']['id_empresa_per'];

        UserInfo.nombre = nombre;
        UserInfo.apellido = apellido;
        UserInfo.idUsuario = idUsuario;
        UserInfo.idEmpresa = idEmpresa;
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
