import 'package:easyfact_mobile/models/producto.dart';
import 'package:easyfact_mobile/services/products_service.dart';
import 'package:flutter/material.dart';

class ProductsSearchDelegate extends SearchDelegate<Producto> {
  final List<Producto> productos;
  ProductsSearchDelegate(this.productos);
  List<Producto> _filter = [];

  ProductsService productsService = ProductsService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          Producto(
            idIvaPer: 0,
            producto: '',
            precio: 0,
            idProducto: 0,
          ),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = productos
        .where((element) =>
            element.producto.toLowerCase().contains(query.toLowerCase()) ||
            element.precio.toString().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(context, _filter[index]);
          },
          title: Text(_filter[index].producto),
          subtitle: Text(_filter[index].precio.toString()),
        );
      },
    );
  }
}
