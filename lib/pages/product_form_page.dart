// ignore_for_file: use_build_context_synchronously

import 'package:easyfact_mobile/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/product_form_provider.dart';
import '../services/products_service.dart';
import '../ui/ui.dart';

class ProductosFormPage extends StatelessWidget {
  const ProductosFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int option = arguments?['option'] as int? ?? 0;
    final Producto? producto = arguments?['producto'] as Producto?;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      'Agregar producto',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ChangeNotifierProvider(
                  create: (_) => ProductFormProvider(),
                  child: _ProductForm(
                    producto: producto,
                    option: option,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.dangerColor,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  final Producto? producto;
  final int option;
  const _ProductForm({
    super.key,
    required this.producto,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final productService = Provider.of<ProductsService>(context);
    return Form(
      key: productForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '1 Libra de carne de res',
              labelText: 'Producto',
            ),
            initialValue: producto?.producto,
            keyboardType: TextInputType.text,
            onChanged: (value) => productForm.producto = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese el nombre del producto';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: FormFieldsStyle().textFormField(
              hintText: '2.50',
              labelText: 'Precio',
            ),
            initialValue: producto?.precio.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => productForm.precio = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese el precio del producto';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          DropdownButtonFormField(
            decoration: FormFieldsStyle().textFormField(
                hintText: 'Seleccione una opción',
                labelText: 'Categoría de IVA'),
            items: const [
              DropdownMenuItem(
                value: 'cero',
                child: Text('IVA 0%'),
              ),
              DropdownMenuItem(
                value: '2',
                child: Text('IVA 12%'),
              ),
            ],
            onChanged: (value) {
              productForm.categoria = value.toString();
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor seleccione una opción';
              }
              return null;
            },
          ),
          const SizedBox(height: 50),
          MaterialButton(
            onPressed: productForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    if (!productForm.isValidForm()) return;

                    productForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    productForm.isLoading = false;
                    if (option == 0) {
                      Producto nuevo = Producto(
                        idIvaPer: productForm.categoria == 'cero' ? 0 : 1,
                        producto: productForm.producto,
                        precio: double.parse(productForm.precio),
                        idProducto: 0,
                      );
                      productService.products.add(nuevo);
                      await productService.createProduct(nuevo);
                    }
                    Navigator.pop(context);
                  },
            color: AppColors.primaryColor,
            minWidth: double.infinity,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
