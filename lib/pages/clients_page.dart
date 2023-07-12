import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                _clientsTitle(),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                                  const Text(
                                    'Nombre del cliente',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  const Text(
                                    'Cedula o RUC',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  const Text(
                                    'Correo electronico',
                                    style: TextStyle(
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
                    },
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
        Navigator.pushNamed(context, '/client_form');
      },
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Container _clientsTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Clientes',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}
