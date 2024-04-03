// Dart
import 'package:flutter_test/flutter_test.dart';
import 'package:input_quantity/src/floating_point.dart';

void main() {
  group('countDecimalPlaces', () {
    test('counts decimal places for positive numbers correctly', () {
      expect(countDecimalPlaces(1.23), equals(2));
      expect(countDecimalPlaces(0.123456), equals(6));
      expect(countDecimalPlaces(123.456), equals(3));
    });

    test('counts decimal places for negative numbers correctly', () {
      expect(countDecimalPlaces(-1.23), equals(2));
      expect(countDecimalPlaces(-0.123456), equals(6));
      expect(countDecimalPlaces(-123.456), equals(3));
    });

    test('returns 0 for numbers with no decimal places', () {
      expect(countDecimalPlaces(1), equals(0));
      expect(countDecimalPlaces(-1), equals(0));
      expect(countDecimalPlaces(0), equals(0));
    });

    test('handles scientific notation correctly', () {
      expect(countDecimalPlaces(1.23e-4), equals(6));
      expect(countDecimalPlaces(1.23e4), equals(0));
      expect(countDecimalPlaces(-1.23e-4), equals(6));
      expect(countDecimalPlaces(-1.23e4), equals(0));
    });

    test('returns the correct index of "e" in the number string', () {
      String numberString = "1.23e-4";
      int indexOfE = numberString.indexOf('e');
      expect(indexOfE, equals(4));
    });

    test(
        'returns the correct index of "e" in the number string for different input',
        () {
      String numberString = "2.345e+10";
      int indexOfE = numberString.indexOf('e');
      expect(indexOfE, equals(5));
    });
  });

  group('addWithPrecision', () {
    test('adds two numbers with precision correctly', () {
      expect(addWithPrecision(1.23456, 2.34567, 2), equals(3.58));
      expect(addWithPrecision(0.123456, 0.234567, 3), equals(0.358));
      expect(addWithPrecision(123.456, 234.567, 0), equals(358));
    });

    test('handles negative numbers correctly', () {
      expect(addWithPrecision(-1.23456, -2.34567, 2), equals(-3.58));
      expect(addWithPrecision(-0.123456, -0.234567, 3), equals(-0.358));
      expect(addWithPrecision(-123.456, -234.567, 0), equals(-358));
    });

    test('handles mixed positive and negative numbers correctly', () {
      expect(addWithPrecision(-1.23456, 2.34567, 2), equals(1.11));
      expect(addWithPrecision(0.123456, -0.234567, 3), equals(-0.111));
      expect(addWithPrecision(123.456, -234.567, 0), equals(-111));
    });
  });

  group('redWithPrecision', () {
    test('subtracts two numbers with precision correctly', () {
      expect(redWithPrecision(2.34567, 1.23456, 2), equals(1.11));
      expect(redWithPrecision(0.234567, 0.123456, 3), equals(0.111));
      expect(redWithPrecision(234.567, 123.456, 0), equals(111));
    });

    test('handles negative numbers correctly', () {
      expect(redWithPrecision(-2.34567, -1.23456, 2), equals(-1.11));
      expect(redWithPrecision(-0.234567, -0.123456, 3), equals(-0.111));
      expect(redWithPrecision(-234.567, -123.456, 0), equals(-111));
    });

    test('handles mixed positive and negative numbers correctly', () {
      expect(redWithPrecision(2.34567, -1.23456, 2), equals(3.58));
      expect(redWithPrecision(0.234567, -0.123456, 3), equals(0.358));
      expect(redWithPrecision(234.567, -123.456, 0), equals(358));
    });
  });
}
