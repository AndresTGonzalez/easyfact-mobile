class CedulaValidator {
  static String? validate(String cedula) {
    if (cedula.isEmpty) {
      return 'La cédula es requerida';
    }

    if (cedula.length != 10) {
      return 'La cédula debe tener 10 dígitos';
    }

    List<int> cedulaDigits = cedula.split('').map(int.parse).toList();

    List<int> weights = [2, 1, 2, 1, 2, 1, 2, 1, 2];

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int multiplied = cedulaDigits[i] * weights[i];
      if (multiplied >= 10) {
        multiplied = multiplied ~/ 10 + multiplied % 10;
      }
      sum += multiplied;
    }

    int remainder = sum % 10;
    int lastDigit = cedulaDigits[9];

    if ((remainder == 0 && lastDigit == 0) || (remainder == 10 - lastDigit)) {
      return null; // Cédula válida
    } else {
      return 'Cédula inválida';
    }
  }
}
