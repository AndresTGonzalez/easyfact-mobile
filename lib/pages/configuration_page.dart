import 'package:easyfact_mobile/constants/app_colors.dart';
import 'package:easyfact_mobile/models/iva.dart';
import 'package:easyfact_mobile/services/iva_service.dart';
import 'package:easyfact_mobile/ui/card_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/form_fields_style.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ChangeNotifierProvider(
            create: (_) => IvaService(),
            child: _IvaSection(),
          ),
        ),
      ),
    );
  }
}

class _IvaSection extends StatelessWidget {
  const _IvaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ivaService = Provider.of<IvaService>(context);
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categorias de IVA',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // ivaService.addTestIva();
                showDialog(
                  context: context,
                  builder: (context) {
                    return _IvaAddForm(
                      ivaService: ivaService,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                color: AppColors.successColor,
                size: 40,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ivaService.categorias.length,
          itemBuilder: (context, index) {
            // return Text(ivaService.categorias[index].iva);
            return _IvaCard(
              iva: ivaService.categorias[index],
            );
          },
        )
      ],
    );
  }
}

class _IvaCard extends StatelessWidget {
  final Iva iva;

  const _IvaCard({
    super.key,
    required this.iva,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: CardDecorations.cardDecoration(),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            '${iva.ivaNombre.toUpperCase()} (${iva.iva}%)',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans',
            ),
          )
        ],
      ),
    );
  }
}

class _IvaAddForm extends StatelessWidget {
  final IvaService ivaService;
  _IvaAddForm({
    super.key,
    required this.ivaService,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.35,
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
            const SizedBox(height: 20),
            Container(
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: FormFieldsStyle().textFormField(
                  hintText: 'Turismo',
                  labelText: 'Nombre',
                ),
                onChanged: (value) => ivaService.iva = value,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: FormFieldsStyle().textFormField(
                  hintText: '12',
                  labelText: 'Porcentaje',
                ),
                onChanged: (value) =>
                    ivaService.porcentaje = double.parse(value),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: double.infinity,
              color: AppColors.primaryColor,
              height: 50,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Crear',
                style: TextStyle(
                  color: AppColors.whiteTextColor,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
