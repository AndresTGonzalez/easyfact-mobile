import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/invoice_service.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceService = Provider.of<InvoiceService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var factura = await invoiceService.createFactura();
          Navigator.pushNamed(
            context,
            '/invoice_form',
            arguments: {'factura': factura},
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: invoiceService.facturas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      width: double.infinity,
                      height: 60,
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
                            width: 40,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            child: const FaIcon(
                              FontAwesomeIcons.fileInvoiceDollar,
                              color: AppColors.successColor,
                              size: 30,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 180,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // '#123456',
                                  invoiceService.facturas[index].numeroFactura
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  invoiceService.facturas[index].idClientePer
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  // 'Fecha: 12/12/2021',
                                  invoiceService.facturas[index].fecha
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                // '\$100.00',
                                '\$${invoiceService.facturas[index].total}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 75.0),
            ],
          ),
        ),
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Facturas',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}
