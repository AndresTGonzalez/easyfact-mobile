// ignore_for_file: use_build_context_synchronously

import 'package:easyfact_mobile/constants/constants.dart';
import 'package:easyfact_mobile/providers/register_form_provider.dart';
import 'package:easyfact_mobile/ui/form_fields_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibir un entero como argumento si es null, se le asigna 0
    final int idEmpresa =
        ModalRoute.of(context)!.settings.arguments as int? ?? 0;
    // final int idEmpresa = ModalRoute.of(context)!.settings.arguments as int;
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: _RegisterForm(
                    idEmpresa: idEmpresa,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final int idEmpresa;
  const _RegisterForm({
    super.key,
    required this.idEmpresa,
  });

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: 'usuario@app.com',
              labelText: 'Correo electrónico',
            ),
            autocorrect: false,
            onChanged: (value) => registerForm.email = value,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Correo electrónico incorrecto';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '**********',
              labelText: 'Contraseña',
            ),
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            onChanged: (value) => registerForm.password = value,
            obscureText: true,
            validator: (value) {
              return (value != null && value.length >= 8)
                  ? null
                  : 'La contraseña debe de ser de 8 caracteres';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '**********',
              labelText: 'Repita la contraseña',
            ),
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            obscureText: true,
            validator: (value) {
              return (value != registerForm.password)
                  ? null
                  : 'Las contraseña no coinciden';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: 'Andrés',
              labelText: 'Nombre',
            ),
            keyboardType: TextInputType.name,
            autocorrect: false,
            onChanged: (value) => registerForm.name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: 'Tapia',
              labelText: 'Apellido',
            ),
            keyboardType: TextInputType.name,
            onChanged: (value) => registerForm.apellido = value,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    if (!registerForm.isValidForm()) return;

                    registerForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    registerForm.isLoading = false;
                    print(idEmpresa);
                    registerForm.register(idEmpresa);
                    // Navigator.pushReplacementNamed(context, '/');
                  },
            minWidth: double.infinity,
            color: AppColors.primaryColor,
            disabledColor: Colors.grey,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              registerForm.isLoading ? 'Espere' : 'Registrarse',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
