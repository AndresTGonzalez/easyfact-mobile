import 'dart:convert';

import 'package:easyfact_mobile/global/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseURL = 'http://34.75.222.189:8000/api/usuario';

  final storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    var url = Uri.parse('$_baseURL/$email/$password');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var nombre = jsonResponse['usuario']['nombre'];
        var apellido = jsonResponse['usuario']['apellido'];
        var idUsuario = jsonResponse['usuario']['id_usuario'];
        var idEmpresa = jsonResponse['usuario']['id_empresa_per'];

        UserInfo.nombre = nombre;
        UserInfo.apellido = apellido;
        UserInfo.idUsuario = idUsuario;
        UserInfo.idEmpresa = idEmpresa;
        await storage.write(
            key: 'idUsuario', value: UserInfo.idUsuario.toString());
        await storage.write(
            key: 'idEmpresa', value: UserInfo.idEmpresa.toString());
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future logout() async {
    await storage.delete(key: 'idUsuario');
  }

  Future userInfo() async {
    String? empresa = await storage.read(key: 'idEmpresa');
    String? usuario = await storage.read(key: 'idUsuario');
    UserInfo.idUsuario = int.parse(usuario!);
    UserInfo.idEmpresa = int.parse(empresa!);
    print(UserInfo.idEmpresa);
  }

  Future<String> readId() async {
    return await storage.read(key: 'idUsuario') ?? '';
  }
}
