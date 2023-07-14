// ignore_for_file: use_build_context_synchronously

import 'package:easyfact_mobile/providers/client_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/cliente.dart';
import '../services/client_service.dart';
import '../ui/ui.dart';
import '../utils/cedula_validator.dart';

class ClientFormPage extends StatelessWidget {
  const ClientFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientService = Provider.of<ClientService>(context);
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int option = arguments?['option'] as int? ?? 0;
    final Cliente client = arguments?['client'] as Cliente;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Spacer(),
                    const Text(
                      'Agregar cliente',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ChangeNotifierProvider(
                  create: (_) => ClientFormProvider(),
                  child: _ClientForm(client: client, option: option),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  onPressed: () {
                    var id = client.numeroIdentificacion;
                    clientService.deleteClient(idCliente: id.toString());
                    Navigator.pop(context);
                  },
                  color: AppColors.dangerColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Eliminar cliente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClientForm extends StatelessWidget {
  final Cliente client;
  final int option;
  const _ClientForm({
    super.key,
    required this.client,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final clientForm = Provider.of<ClientFormProvider>(context);
    final clientService = Provider.of<ClientService>(context);
    return Form(
      key: clientForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '1800000000001',
              labelText: 'Cédula o RUC',
            ),
            onChanged: (value) => clientForm.cedula = value,
            // initialValue: clientService.selectedClient.numeroIdentificacion,
            initialValue: client.numeroIdentificacion,
            keyboardType: TextInputType.number,
            validator: (value) => CedulaValidator.validate(value.toString()),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: 'Andrés Tapia',
              labelText: 'Nombre',
            ),
            keyboardType: TextInputType.text,
            // initialValue: clientService.selectedClient.nombre,
            initialValue: client.nombre,
            onChanged: (value) => clientForm.nombre = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese el nombre del cliente';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: FormFieldsStyle().textFormField(
              hintText: 'usuario@app.com',
              labelText: 'Correo electrónico',
            ),
            // initialValue: clientService.selectedClient.correo,
            initialValue: client.correo,
            onChanged: (value) => clientForm.correo = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: 'Ambato. Av. Bolivariana',
              labelText: 'Dirección',
            ),
            onChanged: (value) => clientForm.direccion = value,
            // initialValue: clientService.selectedClient.direccion,
            // initialValue: client.direccion,
            controller: TextEditingController(
              text: client.direccion,
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese la dirección del cliente';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '0999988888',
              labelText: 'Teléfono',
            ),

            // initialValue: clientService.selectedClient.telefono,
            // initialValue: client.telefono,
            controller: TextEditingController(text: client.telefono),
            keyboardType: TextInputType.phone,
            onChanged: (value) => clientForm.telefono = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese el teléfono del cliente';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          MaterialButton(
            onPressed: clientForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    // if (!clientForm.isValidForm()) return;

                    clientForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    clientForm.isLoading = false;
                    var id = client.idCliente;
                    if (option == 0) {
                      Cliente cliente = Cliente(
                        idCliente: 0,
                        numeroIdentificacion: clientForm.cedula,
                        nombre: clientForm.nombre,
                        apellido: '',
                        correo: clientForm.correo,
                        direccion: clientForm.direccion,
                        telefono: clientForm.telefono,
                        tipoPersona: 'Natural',
                      );
                      clientService.clients.add(cliente);
                      clientService.crearCliente(cliente);
                    } else {
                      var nombre = clientForm.nombre == ''
                          ? client.nombre
                          : clientForm.nombre;
                      var cedula = clientForm.cedula == ''
                          ? client.numeroIdentificacion
                          : clientForm.cedula;
                      var correo = clientForm.correo == ''
                          ? client.correo
                          : clientForm.correo;
                      var direccion = clientForm.direccion == ''
                          ? client.direccion
                          : clientForm.direccion;
                      var telefono = clientForm.telefono == ''
                          ? client.telefono
                          : clientForm.telefono;
                      Cliente editar = Cliente(
                        idCliente: id,
                        numeroIdentificacion: cedula,
                        nombre: nombre,
                        apellido: '',
                        correo: correo,
                        direccion: direccion,
                        telefono: telefono,
                        tipoPersona: 'Natural',
                      );
                      clientService.updateClient(editar);
                      clientService.clients.map((e) {
                        if (e.idCliente == id) {
                          e.numeroIdentificacion = cedula;
                          e.nombre = nombre;
                          e.correo = correo;
                          e.direccion = direccion;
                          e.telefono = telefono;
                        }
                      }).toList();
                    }
                    Navigator.pop(context);
                  },
            color: AppColors.primaryColor,
            minWidth: double.infinity,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
