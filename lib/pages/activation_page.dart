import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../ui/ui.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      width: 50,
                      child: Image.asset('assets/images/isotipo_menta.png'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 75,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Activa EasyFact',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: '1234567890',
                    labelText: 'Código de activación',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el código de activación';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-company');
                  },
                  color: AppColors.primaryColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Activar',
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '¿Aún no tienes una clave?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/activation');
                  },
                  color: AppColors.successColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Solicita una clave de producto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
