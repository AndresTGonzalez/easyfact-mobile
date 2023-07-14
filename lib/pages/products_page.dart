import 'package:easyfact_mobile/models/producto.dart';
import 'package:easyfact_mobile/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../utils/products_search.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Row _productsTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Productos',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductsSearchDelegate(
                    Provider.of<ProductsService>(context, listen: false)
                        .products),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Producto producto = Producto(
            idIvaPer: 0,
            idProducto: 0,
            producto: '',
            precio: 0,
          );
          Navigator.pushNamed(
            context,
            '/product_form',
            arguments: {
              'option': 0,
              'producto': producto,
            },
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                _productsTitle(context),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productsService.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/product_form',
                            arguments: {
                              'option': 1,
                              'producto': productsService.products[index],
                            },
                          );
                        },
                        child: _ProductCard(
                            producto: productsService.products[index]),
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
}

class _ProductCard extends StatelessWidget {
  final Producto producto;

  const _ProductCard({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
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
              FontAwesomeIcons.box,
              color: AppColors.successColor,
              size: 30,
            ),
          ),
          const Spacer(),
          Container(
            width: 180,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.centerLeft,
            child: Text(
              // 'producto',
              producto.producto,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Text(
            // '\$25',
            '\$${producto.precio}',
          ),
          const Spacer()
        ],
      ),
    );
  }
}
