import 'package:easyfact_mobile/constants/constants.dart';
import 'package:easyfact_mobile/pages/pages.dart';
import 'package:easyfact_mobile/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const Scaffold(
        bottomNavigationBar: _Navigation(),
        body: _Pages(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<NavigationProvider>(context);
    return PageView(
      controller: navigation.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        InvoicesPage(),
        ClientsPage(),
        ProductsPage(),
        // InvoicesPage(),
        ConfigurationPage()
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return BottomNavigationBar(
      onTap: (value) => navigationProvider.currentIndex = value,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.successColor,
      unselectedItemColor: AppColors.whiteTextColor,
      currentIndex: navigationProvider.currentIndex,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const [
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
          label: 'Facturas',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.users),
          label: 'Clientes',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bagShopping),
          label: 'Productos',
        ),
        // BottomNavigationBarItem(
        //   icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
        //   label: 'Documentos',
        // ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: 'Configuración',
        ),
      ],
    );
  }
}
