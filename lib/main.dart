import 'package:flutter/material.dart';

import 'pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyFact',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const Home(),
        '/register-company': (context) => const RegisterCompanyPage(),
        '/activation': (context) => const ActivationPage(),
        '/user': (context) => const UserPage(),
        '/client_form': (context) => const ClientFormPage(),
        '/product_form': (context) => const ProductosFormPage(),
        '/invoice_form': (context) => const InvoiceFormPage(),
      },
    );
  }
}
