// ignore_for_file: use_build_context_synchronously

import 'package:easyfact_mobile/constants/constants.dart';
import 'package:easyfact_mobile/providers/login_form_provider.dart';
import 'package:easyfact_mobile/services/auth_service.dart';
import 'package:easyfact_mobile/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _logo(context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Container _logo(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child: Image.asset(
        'assets/images/logo.png',
        width: MediaQuery.of(context).size.width * 0.75,
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final auth = Provider.of<AuthService>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: FormFieldsStyle().textFormField(
              hintText: 'usuario@app.com',
              labelText: 'Correo electrónico',
            ),
            onChanged: (value) => loginForm.email = value,
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
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => loginForm.password = value,
            decoration: FormFieldsStyle().textFormField(
              hintText: '***********',
              labelText: 'Contraseña',
            ),
            validator: (value) {
              return (value != null && value.length >= 8)
                  ? null
                  : 'La contraseña debe de ser de 8 caracteres';
            },
          ),
          const SizedBox(height: 50),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    if (!loginForm.isValidForm()) return;
                    var loginOK =
                        // AuthService.login(loginForm.email, loginForm.password);
                        auth.login(loginForm.email, loginForm.password);
                    if (await loginOK) {
                      auth.userInfo();
                      loginForm.isLoading = true;
                      await Future.delayed(const Duration(seconds: 2));
                      loginForm.isLoading = false;
                      Navigator.pushNamed(context, '/home');
                    } else {
                      // Mostrar dialogo de error
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Usuario o contraseña incorrectos'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Ok'),
                                )
                              ],
                            );
                          });
                    }
                  },
            minWidth: double.infinity,
            color: AppColors.primaryColor,
            disabledColor: Colors.grey,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              loginForm.isLoading ? 'Espere' : 'Ingresar',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register-company');
            },
            minWidth: double.infinity,
            color: AppColors.successColor,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Registrarse',
              style: TextStyle(
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
