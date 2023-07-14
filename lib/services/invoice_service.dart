import 'package:flutter/material.dart';

import '../models/cliente.dart';

class InvoiceService extends ChangeNotifier {
  static const String _baseUrl = '';
  Cliente cliente = Cliente(
      numeroIdentificacion: '9999999999999',
      nombre: 'Consumidor final',
      apellido: 'apellido',
      correo: 'XXXXXXXXXX',
      direccion: 'xxxxxx',
      telefono: '999999999',
      tipoPersona: 'Natural');

  void setCliente(Cliente cliente) {
    this.cliente = cliente;
    notifyListeners();
  }
}
