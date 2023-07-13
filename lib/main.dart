import 'package:easyfact_mobile/providers/navigation_provider.dart';
import 'package:easyfact_mobile/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/pages.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientService()),
        ChangeNotifierProvider(create: (_) => NavigationProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyFact',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
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
        '/invoices': (context) => const InvoicesPage(),
      },
    );
  }
}
