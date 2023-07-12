import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Bienvenido, usuario',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/user');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '¿Cómo va tu negocio?',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 30,
                      child: const Text(
                        'Tu producto más vendido',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 40,
                      child: const Text(
                        'Quintal de arroz',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 30,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 30,
                      child: const Text(
                        '100 unidades vendidas este mes',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 30,
                      child: const Text(
                        'Tu cliente más frecuente',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 40,
                      child: const Text(
                        'Daniel González',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 30,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 30,
                      child: const Text(
                        '\$2.500 en compras este mes',
                        style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Crear una transacción',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/invoice_form');
                        },
                        color: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 100,
                        child: const Text(
                          'Factura',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteTextColor,
                            fontSize: 16,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: MaterialButton(
                        onPressed: () {},
                        color: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 100,
                        child: const Text(
                          'Nota de crédito',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteTextColor,
                            fontSize: 16,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
