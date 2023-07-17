import 'package:easyfact_mobile/pages/home.dart';
import 'package:easyfact_mobile/pages/login_page.dart';
import 'package:easyfact_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: auth.readId(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Home(),
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
