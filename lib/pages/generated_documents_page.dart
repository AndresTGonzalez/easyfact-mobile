import 'package:easyfact_mobile/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneratedDocuments extends StatelessWidget {
  const GeneratedDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatinActionButtonCustom(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                _pageTitle(),
                const SizedBox(height: 35.0),
                _invoiceSectionHeader(context),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.successColor,
                        ),
                        margin: const EdgeInsets.only(right: 20.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#123456789',
                              style: _documentNumberStyle(),
                            ),
                            Text(
                              'Juan Perez',
                              style: _clientTextStyle(),
                            ),
                            Text(
                              '\$ 100.00',
                              style: _totalValueStyle(),
                            ),
                            const SizedBox(height: 5),
                            _status(textColor: AppColors.successColor),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                _creditNotesSectionHeader(),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 165,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.dangerColor,
                        ),
                        margin: const EdgeInsets.only(right: 20.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#123456789',
                              style: _documentNumberStyle(),
                            ),
                            Text(
                              'Juan Perez',
                              style: _clientTextStyle(),
                            ),
                            Text(
                              '\$ 100.00',
                              style: _totalValueStyle(),
                            ),
                            const SizedBox(height: 5),
                            _status(textColor: AppColors.dangerColor),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _status({
    required Color textColor,
  }) {
    return Container(
      width: 100,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.whiteBackgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        'Aprobado',
        style: _statusTextStyle(textColor: textColor),
      ),
    );
  }

  TextStyle _statusTextStyle({
    required Color textColor,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: 15,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _totalValueStyle() {
    return TextStyle(
      color: AppColors.whiteBackgroundColor,
      fontSize: 30,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _clientTextStyle() {
    return TextStyle(
      color: AppColors.whiteBackgroundColor,
      fontSize: 20,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _documentNumberStyle() {
    return TextStyle(
      color: AppColors.whiteBackgroundColor,
      fontSize: 15,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
    );
  }

  Container _invoiceSectionHeader(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      // color: AppColors.blackTextColor,
      child: Row(
        children: [
          Text(
            'Facturas',
            style: _seccionLabelStyle(),
          ),
          const Spacer(),
          MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/invoices');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              child: const Text(
                'Ver más',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 13,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }

  Container _creditNotesSectionHeader() {
    return Container(
      height: 50,
      width: double.infinity,
      // color: AppColors.blackTextColor,
      child: Row(
        children: [
          Text(
            'Facturas',
            style: _seccionLabelStyle(),
          ),
          const Spacer(),
          MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              child: const Text(
                'Ver más',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 13,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }

  TextStyle _seccionLabelStyle() {
    return TextStyle(
      color: AppColors.blackTextColor,
      fontSize: 20,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    );
  }

  Container _pageTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Documentos generados',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  SpeedDial _floatinActionButtonCustom(BuildContext context) {
    return SpeedDial(
      backgroundColor: AppColors.primaryColor,
      activeBackgroundColor: AppColors.successColor,
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 20,
      children: [
        SpeedDialChild(
          child: const Icon(
            FontAwesomeIcons.fileInvoiceDollar,
            color: AppColors.primaryColor,
          ),
          label: 'Factura',
          onTap: () {
            Navigator.pushNamed(context, '/invoice_form');
          },
        ),
        SpeedDialChild(
          child: const Icon(
            FontAwesomeIcons.moneyCheckDollar,
            color: AppColors.primaryColor,
          ),
          label: 'Nota de crédito',
          onTap: () {},
        ),
      ],
    );
  }
}
