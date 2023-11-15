import 'dart:math';

/// sum 2 numbers with precission
double addWithPrecision(num a, num b, int precision) {
  num multiplier = pow(10, precision);
  int result = (a * multiplier).round() + (b * multiplier).round();
  return result / multiplier;
}

/// substract 2 numbers with precission
double redWithPrecision(num a, num b, int precision) {
  num multiplier = pow(10, precision);
  int result = (a * multiplier).round() - (b * multiplier).round();
  return result / multiplier;
}

/// count number of decimal places
int countDecimalPlaces(num number) {
  String numberString = number.toString().toLowerCase();

  if (numberString.contains('e')) {
    // Handle scientific notation
    int indexOfE = numberString.indexOf('e');
    String mantissa = numberString.substring(0, indexOfE);

    // Count decimal places in the mantissa
    int decimalPlaces = countDecimalPlaces(double.parse(mantissa));

    // Adjust for the exponent in scientific notation
    int exponent = int.parse(numberString.substring(indexOfE + 1));
    return decimalPlaces - exponent;
  } else if (numberString.contains('.')) {
    // Handle regular decimal notation
    String decimalPart = numberString.split('.')[1];
    return decimalPart.length;
  } else {
    // If there is no decimal point, return 0
    return 0;
  }
}
