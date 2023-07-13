import 'package:easyfact_mobile/services/client_service.dart';
import 'package:easyfact_mobile/utils/clients_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/cliente.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientService = Provider.of<ClientService>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var cliente = Cliente(
            idCliente: 0,
            numeroIdentificacion: '',
            nombre: '',
            apellido: '',
            correo: '',
            direccion: '',
            telefono: '',
            tipoPersona: '',
          );
          Navigator.pushNamed(context, '/client_form', arguments: cliente);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                _clientsTitle(context),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: clientService.clients.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // itemBuilder: (context, index) {
                    //   return ClientCard(cliente: clientService.clients[index]);
                    // },
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        // clientService.selectedClient =
                        //     clientService.clients[index].copy();
                        // Navigator.pushNamed(context, '/client_form');
                        print(clientService.clients[index].telefono);
                        Navigator.pushNamed(
                          context,
                          '/client_form',
                          arguments: clientService.clients[index],
                        );
                      },
                      child: ClientCard(cliente: clientService.clients[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        var cliente = Cliente(
          idCliente: 0,
          numeroIdentificacion: '',
          nombre: '',
          apellido: '',
          correo: '',
          direccion: '',
          telefono: '',
          tipoPersona: '',
        );
        Navigator.pushNamed(context, '/client_form', arguments: cliente);
      },
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Row _clientsTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Clientes',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/client_search');
              showSearch(
                context: context,
                delegate: SearchClientDelegate(
                    Provider.of<ClientService>(context, listen: false).clients),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class ClientCard extends StatelessWidget {
  final Cliente cliente;

  const ClientCard({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.whiteBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            alignment: Alignment.center,
            child: const FaIcon(
              FontAwesomeIcons.userTie,
              size: 40,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 0.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${cliente.nombre} ${cliente.apellido}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Text(
                  cliente.numeroIdentificacion,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Text(
                  cliente.correo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
