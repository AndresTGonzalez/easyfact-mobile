import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String producto = '';
  String precio = '';
  int categoria = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
