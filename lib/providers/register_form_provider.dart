import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String apellido = '';

  static const String _baseUrl = '34.75.222.189:8000';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void testFields() {
    print('Email: $email');
    print('Password: $password');
    print('Name: $name');
    print('Apellido: $apellido');
  }

  Future register(int idEmpresa) async {
    final url = Uri.http(_baseUrl, '/api/usuario/');
    final data = {
      "id_empresa_per": idEmpresa,
      "correo": email,
      "nombre": name,
      "apellido": apellido,
      "contrasena": password
    };

    final response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    print(response.body);
  }
}
