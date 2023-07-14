import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:easyfact_mobile/ui/card_decorations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/invoice_service.dart';

class InvoiceFormPage extends StatelessWidget {
  const InvoiceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _Header(),
                SizedBox(height: 20.0),
                _DateDetail(),
                SizedBox(height: 20.0),
                _ClientDetail(),
                SizedBox(height: 20.0),
                _InvoiceDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceDetail extends StatelessWidget {
  const _InvoiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: CardDecorations.cardDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Detalle de la factura',
                style: CardDecorations.titleCardTextStyle(),
              ),
              const Spacer(),
              const FaIcon(
                FontAwesomeIcons.circlePlus,
                color: AppColors.successColor,
                size: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Producto',
                          style: CardDecorations.detailProductTextStyle(),
                        ),
                        Text(
                          'Cant. 5 * \$50',
                          style: CardDecorations
                              .detailProductDescriptionTextStyle(),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$250',
                      style: CardDecorations.detailProductPriceTextStyle(),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _ClientDetail extends StatelessWidget {
  const _ClientDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceService = Provider.of<InvoiceService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: CardDecorations.cardDecoration(),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.userTie,
            color: AppColors.successColor,
            size: 40.0,
          ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cliente',
                style: CardDecorations.titleCardTextStyle(),
              ),
              Text(
                // 'Nombre del cliente',
                invoiceService.cliente.nombre,
                style: CardDecorations.subtitleCardTextStyle(),
              ),
              Text(
                // 'Número de identificación',
                invoiceService.cliente.numeroIdentificacion,
                style: CardDecorations.subtitleCardTextStyle(),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            alignment: Alignment.center,
            onPressed: () {
              Navigator.pushNamed(context, '/clients', arguments: 1);
            },
            icon: const FaIcon(
              FontAwesomeIcons.penToSquare,
              color: AppColors.successColor,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateDetail extends StatelessWidget {
  const _DateDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: CardDecorations.cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#123456789',
                style: CardDecorations.titleCardTextStyle(),
              ),
              Text(
                '05/05/2023',
                style: CardDecorations.subtitleCardTextStyle(),
              ),
            ],
          ),
          const Spacer(),
          const FaIcon(
            FontAwesomeIcons.fileInvoiceDollar,
            color: AppColors.successColor,
            size: 60.0,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            'Nueva factura',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
