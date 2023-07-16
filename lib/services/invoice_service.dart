import 'dart:convert';

import 'package:easyfact_mobile/models/create_factura.dart';
import 'package:easyfact_mobile/models/factura.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/user_info.dart';
import '../models/cliente.dart';

class InvoiceService extends ChangeNotifier {
  static const String _baseUrl = '34.75.222.189:8000';
  Cliente cliente = Cliente(
      numeroIdentificacion: '9999999999999',
      nombre: 'Consumidor final',
      apellido: 'apellido',
      correo: 'XXXXXXXXXX',
      direccion: 'xxxxxx',
      telefono: '999999999',
      tipoPersona: 'Natural');

  final List<Factura> facturas = [];

  InvoiceService() {
    loadFacturas();
  }

  void setCliente(Cliente cliente) {
    this.cliente = cliente;
    notifyListeners();
  }

  Future cerrarFactura(int idFactura) async {
    final url = Uri.http(_baseUrl, '/api/cerrarfactura/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'id_factura_per': idFactura,
      'id_cliente_per': cliente.numeroIdentificacion,
      "id_forma_pago_per": 1
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Error en la solicitud POST');
    }
  }

  Future getCliente(String cedula) async {
    final url =
        Uri.http(_baseUrl, '/api/cliente/${UserInfo.idEmpresa}/$cedula/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final cliente = Cliente(
          numeroIdentificacion: jsonData['numero_identificacion'],
          nombre: jsonData['nombre'],
          apellido: jsonData['apellido'],
          correo: jsonData['correo'],
          direccion: jsonData['direccion'],
          telefono: jsonData['telefono'],
          tipoPersona: jsonData['tipo_persona']);
      setCliente(cliente);
    } else {
      throw Exception('Error en la solicitud GET');
    }
  }

  Future<CreateFactura> createFactura() async {
    final url = Uri.http(_baseUrl, '/api/abrirfactura/');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> jsonData = {
      'id_usuario_per': UserInfo.idUsuario,
    };

    final body = jsonEncode(jsonData);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final facturaData = jsonData['factura'] as List<dynamic>;
      final factura = facturaData.map((facturaData) {
        return CreateFactura(
            numeroFactura: facturaData['numero_factura'],
            idDocumentoPer: facturaData['id_documento_per'],
            idFormaPagoPer: facturaData['id_forma_pago_per'],
            idUsuarioPer: facturaData['id_usuario_per'],
            idClientePer: facturaData['id_cliente_per'],
            idFactura: facturaData['id_factura'],
            claveAcceso: facturaData['clave_acceso'],
            fecha: DateTime.parse(facturaData['fecha']),
            subtotal: 0,
            totalIva: 0,
            total: 0);
      }).toList();
      notifyListeners();
      return factura[0];
    } else {
      throw Exception('Error en la solicitud POST');
    }
  }

  Future loadFacturas() async {
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/verFacturas/${UserInfo.idEmpresa}/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final facturasData = jsonData['Facturas'] as List<dynamic>;
      final facturas = facturasData.map((facturaData) {
        return Factura(
            numeroFactura: facturaData['numero_factura'],
            idDocumentoPer: facturaData['id_documento_per'],
            idFormaPagoPer: facturaData['id_forma_pago_per'],
            idUsuarioPer: facturaData['id_usuario_per'],
            idClientePer: facturaData['id_cliente_per'],
            idFactura: facturaData['id_factura'],
            claveAcceso: facturaData['clave_acceso'],
            fecha: DateTime.parse(facturaData['fecha']),
            subtotal: double.parse(facturaData['subtotal']),
            totalIva: double.parse(facturaData['total_iva']),
            total: double.parse(facturaData['total']));
      }).toList();
      this.facturas.addAll(facturas);
    } else {
      throw Exception('Error en la solicitud GET');
    }
    notifyListeners();
  }
}
