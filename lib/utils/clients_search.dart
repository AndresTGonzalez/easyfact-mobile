import 'package:easyfact_mobile/models/cliente.dart';
import 'package:easyfact_mobile/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchClientDelegate extends SearchDelegate<Cliente> {
  final List<Cliente> clientes;

  SearchClientDelegate(this.clientes);
  List<Cliente> _filter = [];

  ClientService clientService = ClientService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
            context,
            Cliente(
                numeroIdentificacion: '',
                nombre: '',
                apellido: '',
                correo: '',
                direccion: '',
                telefono: '',
                tipoPersona: ''));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = clientes
        .where((element) =>
            element.nombre.toLowerCase().contains(query.toLowerCase()) ||
            element.apellido.toLowerCase().contains(query.toLowerCase()) ||
            element.numeroIdentificacion
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.telefono.toLowerCase().contains(query.toLowerCase()) ||
            element.correo.toLowerCase().contains(query.toLowerCase()) ||
            element.direccion.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // clientService.selectedClient = _filter[index].copy();
            var cliente = _filter[index].copy();
            Navigator.pushNamed(
              context,
              '/client_form',
              arguments: cliente,
            );
          },
          leading: const Icon(FontAwesomeIcons.user),
          title: Text(
            '${_filter[index].nombre} ${_filter[index].apellido}',
            style: const TextStyle(fontSize: 16.0),
          ),
          subtitle: Text(
            _filter[index].numeroIdentificacion,
            style: const TextStyle(fontSize: 14.0),
          ),
        );
      },
    );
  }
}
