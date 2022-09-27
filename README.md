# Input Quantity

[![pub package](https://img.shields.io/pub/v/input_quantity.svg)](https://pub.dev/packages/input_quantity)
[![package publisher](https://img.shields.io/pub/publisher/logo_n_spinner.svg)](https://pub.dev/publishers/pmatatias.dev/packages)

A flutter widget for input quantity. Increase or decrease number of input by press the button. Also support for type manually the number of quantity. The value will automatically return to maximum value that already set.
Cursor will automatic move to right side after typing.

## Features

- Simple quantity input
- Function to move cursor automatically
- Return to max value

## Usage

example:

```dart
import 'package:input_quantity/input_quantity.dart';
...
    InputQty(
        maxVal: 100,
        initVal: 0,
        onQtyChanged: (val) {
            print(val);
        },
    ),
```

## Additional information

To contrib to this project, you can open a PR or an issue.

## Buy me a coffe

Want to thank me? you can buy me a coffe
https://www.buymeacoffee.com/pmatatias
