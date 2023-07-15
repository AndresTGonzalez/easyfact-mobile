import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:easyfact_mobile/models/producto.dart';
import 'package:easyfact_mobile/ui/card_decorations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/create_factura.dart';
import '../services/invoice_detail_service.dart';
import '../services/invoice_service.dart';

class InvoiceFormPage extends StatelessWidget {
  const InvoiceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final CreateFactura factura = arguments?['factura'] as CreateFactura;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const _Header(),
                const SizedBox(height: 20.0),
                _DateDetail(factura: factura),
                const SizedBox(height: 20.0),
                const _ClientDetail(),
                const SizedBox(height: 20.0),
                _InvoiceDetail(
                  factura: factura,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddDetailForm extends StatelessWidget {
  final CreateFactura factura;
  const _AddDetailForm({
    super.key,
    required this.factura,
  });

  @override
  Widget build(BuildContext context) {
    final invoiceDetailService = Provider.of<InvoiceDetailService>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agregar detalle',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/products', arguments: 2);
              },
              child: invoiceDetailService.selectedProduct.producto == ''
                  ? const Text(
                      'Seleccionar producto',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'OpenSans',
                      ),
                    )
                  : TextFormField(
                      enabled: false,
                      initialValue:
                          invoiceDetailService.selectedProduct.producto,
                      decoration: InputDecoration(
                        labelText: 'Producto',
                        labelStyle: const TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'OpenSans',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => invoiceDetailService.cantidad = int.parse(
                value == '' ? '0' : value,
              ),
              decoration: InputDecoration(
                labelText: 'Cantidad',
                labelStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'OpenSans',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Precio',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Spacer(),
                Text(
                  // 'data',
                  '\$${invoiceDetailService.selectedProduct.precio}',
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text('Subtotal'),
                const Spacer(),
                Text(
                  // 'data',
                  '\$${invoiceDetailService.selectedProduct.precio * invoiceDetailService.cantidad}',
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              minWidth: 400,
              onPressed: () async {
                await invoiceDetailService.addDetalle(factura.idFactura!);
                invoiceDetailService.printLength();
                invoiceDetailService.cantidad = 1;
                invoiceDetailService.selectedProduct = Producto(
                    idIvaPer: 0, idProducto: 0, producto: '', precio: 0);
                Navigator.pop(context);
              },
              color: AppColors.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 5.0),
            MaterialButton(
              minWidth: 400,
              onPressed: () {
                invoiceDetailService.cantidad = 1;
                invoiceDetailService.selectedProduct = Producto(
                    idIvaPer: 0, idProducto: 0, producto: '', precio: 0);
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
              color: AppColors.dangerColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceDetail extends StatelessWidget {
  final CreateFactura factura;
  const _InvoiceDetail({
    super.key,
    required this.factura,
  });

  @override
  Widget build(BuildContext context) {
    final invoiceDetailService = Provider.of<InvoiceDetailService>(context);
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
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _AddDetailForm(
                          factura: factura,
                        );
                      });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: AppColors.successColor,
                  size: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: invoiceDetailService.detalles.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Producto',
                          invoiceDetailService.detalles[index].producto,
                          // invoiceDetailService.detalles[index],
                          style: CardDecorations.detailProductTextStyle(),
                        ),
                        Text(
                          'Cant. ${invoiceDetailService.detalles[index].cantidad} * \$${invoiceDetailService.detalles[index].precio}',
                          style: CardDecorations
                              .detailProductDescriptionTextStyle(),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$${invoiceDetailService.detalles[index].cantidad * invoiceDetailService.detalles[index].precio}',
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
  final CreateFactura factura;
  const _DateDetail({
    super.key,
    required this.factura,
  });

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
                // '#123456789',
                factura.idFactura.toString(),
                style: CardDecorations.titleCardTextStyle(),
              ),
              const SizedBox(height: 2),
              Text(
                // '05/05/2023',
                factura.fecha.toString(),
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
    final invoiceDetailService = Provider.of<InvoiceDetailService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              invoiceDetailService.detalles.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            'Nueva factura',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
