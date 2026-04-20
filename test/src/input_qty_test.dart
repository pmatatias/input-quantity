import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_quantity/input_quantity.dart';

void main() {
  group('InputQty', () {
    test('should create InputQty widget successfully', () {
      var widget = InputQty(
        qtyFormProps: const QtyFormProps(),
        messageBuilder: (num value, num? minValue, num? maxValue) =>
            Text('Value: $value'),
        decimalPlaces: 2,
      );

      expect(widget, isNotNull);
    });

    test('should set qtyFormProps correctly', () {
      var props = const QtyFormProps();
      var widget = InputQty(qtyFormProps: props);

      expect(widget.qtyFormProps, equals(props));
    });

    test('should set messageBuilder correctly', () {
      Text builder(num value, num? minValue, num? maxValue) =>
          Text('Value: $value');
      var widget = InputQty(
        messageBuilder: builder,
      );

      expect(widget.messageBuilder, equals(builder));
    });

    test('should set decimalPlaces correctly', () {
      var widget = const InputQty(decimalPlaces: 2);

      expect(widget.decimalPlaces, equals(2));
    });
  });

  group('decimalSeparator', () {
    test('should default to null', () {
      var widget = const InputQty();
      expect(widget.decimalSeparator, isNull);
    });

    test('should accept custom decimal separator', () {
      var widget = const InputQty(decimalSeparator: ',');
      expect(widget.decimalSeparator, equals(','));
    });

    test('should accept decimal separator in InputQty.double', () {
      var widget = const InputQty.double(decimalSeparator: ',');
      expect(widget.decimalSeparator, equals(','));
    });

    test('should accept decimal separator in InputQty.int', () {
      var widget = const InputQty.int(decimalSeparator: ',');
      expect(widget.decimalSeparator, equals(','));
    });
  });
}
