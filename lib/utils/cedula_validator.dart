class CedulaValidator {
  static String? validate(String cedula) {
    if (cedula.isEmpty) {
      return 'El número de identificación es requerido';
    }

    if (cedula.length == 10 || cedula.length == 13) {
      List<int> cedulaDigits =
          cedula.substring(0, 10).split('').map(int.parse).toList();

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
        if (cedula.length == 13) {
          if (cedula.substring(10) == '001') {
            return null; // RUC válido
          } else {
            return 'RUC inválido';
          }
        }
        return null; // Cédula válida
      } else {
        return 'Número de identificación inválido';
      }
    }

    return 'El número de identificación debe tener 10 dígitos (cédula) o 13 dígitos (RUC)';
  }
}
