import 'dart:convert';
import 'package:easyfact_mobile/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  final List<Cliente> clients = [];
  late Cliente selectedClient;
  bool isLoading = true;

  ClientService() {
    // _getClients();
    loadClients();
  }

  Future<void> crearCliente(Cliente cliente) async {
    final url = Uri.http(_baseUrl, '/api/cliente/1851003564001/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(cliente.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print('Se logro');
    } else {
      throw Exception('Error en la solicitud POST');
    }
  }

  Future loadClients() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/api/cliente/1851003564001/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final clientesData = jsonData['clientes'] as List<dynamic>;

      final clientes = clientesData.map((clienteData) {
        return Cliente(
          idCliente: clienteData['id_cliente'],
          numeroIdentificacion: clienteData['numero_identificacion'],
          nombre: clienteData['nombre'],
          apellido: clienteData['apellido'],
          correo: clienteData['correo'],
          direccion: clienteData['direccion'],
          telefono: clienteData['telefono'],
          tipoPersona: clienteData['tipo_persona'],
        );
      }).toList();
      clients.addAll(clientes);
    } else {
      throw Exception('Error al cargar los clientes');
    }
    // isLoading = false;
    notifyListeners();
  }
}
