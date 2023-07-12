import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvoiceFormPage extends StatelessWidget {
  const InvoiceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Column(
                  children: [
                    _numberDateCard(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _clientCard(context),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _headerDetailCard(),
                    Container(
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  margin: const EdgeInsets.only(left: 10),
                                  width: 190,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Producto',
                                        style: _detailCardProduct(),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Cant. 5 x \$ 50',
                                        style: _cuantityDetailStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: 75,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '\$ 250.00',
                                    style: _subtotalDetailStyle(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _sumaryCard(),
              const SizedBox(height: 30),
              _createInvoiceButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _subtotalDetailStyle() {
    return TextStyle(
      color: const Color.fromARGB(255, 141, 87, 87),
      fontSize: 16,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _cuantityDetailStyle() {
    return TextStyle(
      color: AppColors.greyTextColor,
      fontSize: 12,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _detailCardProduct() {
    return TextStyle(
      color: AppColors.blackTextColor,
      fontSize: 13,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    );
  }

  Container _createInvoiceButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        onPressed: () {},
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Crear factura',
          style: TextStyle(
            color: AppColors.whiteBackgroundColor,
            fontSize: 15,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container _sumaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Subtotal',
                      style: _sumaryLabelBold(),
                    ),
                    const Spacer(),
                    Text('data'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Descuento',
                      style: _sumaryLabelBold(),
                    ),
                    const Spacer(),
                    Text('data'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'IVA',
                      style: _sumaryLabelBold(),
                    ),
                    const Spacer(),
                    Text('data'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: _sumaryLabelBold(),
                    ),
                    const Spacer(),
                    Text('data'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Forma de pago',
                      style: _sumaryLabelBold(),
                    ),
                    const Spacer(),
                    Text('data'),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _sumaryLabelBold() {
    return TextStyle(
      color: AppColors.blackTextColor,
      fontSize: 13,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    );
  }

  Container _headerDetailCard() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detalle',
            style: _boldTextStyle(),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.circlePlus,
              size: 20,
              color: AppColors.successColor,
            ),
          ),
        ],
      ),
    );
  }

  Container _clientCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: const FaIcon(
              FontAwesomeIcons.userTie,
              size: 40,
              color: AppColors.successColor,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 175,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cliente',
                  style: _boldTextStyle(),
                ),
                Text(
                  'Consumidor Final',
                  style: _grayTextStyle(),
                ),
                Text(
                  '0000000000',
                  style: _grayTextStyle(),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 75,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.penToSquare,
                size: 35,
                color: AppColors.successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.whiteBackgroundColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  TextStyle _grayTextStyle() {
    return const TextStyle(
      color: AppColors.greyTextColor,
      fontSize: 13,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _boldTextStyle() {
    return const TextStyle(
      color: AppColors.blackTextColor,
      fontSize: 15,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    );
  }

  Container _numberDateCard(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 7,
      ),
      height: 75,
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '#123456789',
                    style: _boldTextStyle(),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '25 de agosto de 2021',
                    style: _grayTextStyle(),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height,
            child: const FaIcon(
              FontAwesomeIcons.fileInvoiceDollar,
              size: 40,
              color: AppColors.successColor,
            ),
          ),
        ],
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
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
          const Text(
            'Crear factura',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
