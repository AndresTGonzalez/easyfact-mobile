import 'package:easyfact_mobile/constants/constants.dart';
import 'package:flutter/material.dart';

import '../ui/ui.dart';

class RegisterCompanyPage extends StatelessWidget {
  const RegisterCompanyPage({super.key});

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
                  'Registra tu empresa',
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
                    hintText: '1800000000001',
                    labelText: 'RUC o RIMPE',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el RUC o RIMPE de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: 'EasyFact S.A',
                    labelText: 'Razón social',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese la razón social de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: 'EasyFact',
                    labelText: 'Nombre comercial',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el nombre comercial de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: 'Ambato. Av. Los Chasquis y Av. Atahualpa',
                    labelText: 'Dirección',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese la dirección de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: '0999988888',
                    labelText: 'Teléfono de contacto',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese la razón social de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButtonFormField(
                  decoration: FormFieldsStyle().textFormField(
                      hintText: 'Seleccione una opción',
                      labelText: 'Obligado a llevar contabilidad'),
                  items: const [
                    // DropdownMenuItem(
                    //   value: '0',
                    //   child: Text('Seleccione una opción'),
                    // ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text('Sí'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButtonFormField(
                  decoration: FormFieldsStyle().textFormField(
                      hintText: 'Seleccione una opción',
                      labelText: 'Tipo de contribuyente'),
                  items: const [
                    // DropdownMenuItem(
                    //   value: '0',
                    //   child: Text('Seleccione una opción'),
                    // ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('Persona natural'),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text('Persona jurídica'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 30),
              Container(
                // Crear un circulo
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(300),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/default.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Tu logo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.successColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Cargar logo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: const Text(
                  'Puedes agregarlo más tarde',
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
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Tu firma electrónica	',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.successColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Cargar firma electrónica',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: FormFieldsStyle().textFormField(
                    hintText: '123456789',
                    labelText: 'La contraseña de tu firma electrónica',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese la razón social de su empresa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: const Text(
                  'Puedes agregarla más tarde',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  color: AppColors.primaryColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Registrar empresa',
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
