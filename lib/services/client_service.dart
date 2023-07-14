import 'dart:convert';
import 'package:easyfact_mobile/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  final List<Cliente> clients = [];
  bool isLoading = true;

  ClientService() {
    // _getClients();
    loadClients();
  }

  int indexOfClient(String? cedula) {
    return clients
        .indexWhere((cliente) => cliente.numeroIdentificacion == cedula);
  }

  Future<void> updateClient(Cliente cliente) async {
    final url = Uri.http(_baseUrl, '/api/cliente/1/${cliente.idCliente}/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(cliente.toJson());

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error en la solicitud PUT');
    }
  }

  Future<bool> deleteClient({required String idCliente}) async {
    final url = Uri.http(_baseUrl, '/api/cliente/1/$idCliente/');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      clients.removeAt(indexOfClient(idCliente.toString()));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> crearCliente(Cliente cliente) async {
    final url = Uri.http(_baseUrl, '/api/cliente/1/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(cliente.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error en la solicitud POST');
    }
  }

  Future loadClients() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/api/cliente/1/');
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
