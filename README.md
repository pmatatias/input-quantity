# Input Quantity

[![pub package](https://img.shields.io/pub/v/input_quantity.svg)](https://pub.dev/packages/input_quantity)
[![package publisher](https://img.shields.io/pub/publisher/logo_n_spinner.svg)](https://pub.dev/publishers/pmatatias.dev/packages)

A Flutter widget for quantity input. Increase or decrease the input value by pressing the button.
Built with text field, **InputQty** also supports to type input quantity manually.
The input value will automatically return to the preset maximum/minimum value.
The cursor will automatically move to the right side after typing.

## Features

- Simple quantity input
- Cursor automatically moves to the right for better user experience
- Set maximum, minimum and initial value
- Deveoped with changenotifier to avoid rebuilding the widget every time it changes its value
- Use the steps to change every key pressed
- Intrinsic and expanded size

## Usage

example:

```dart
import 'package:input_quantity/input_quantity.dart';
...
  InputQty(
    maxVal: 100,
    initVal: 0,
    minVal: -100,
    isIntrinsicWidth: false,
    steps: 10,
    onQtyChanged: (val) {
      print(val);
    },
  ),
```

## To Do

- Develop Widgets of alternative `IntrinsicHeight` and `IntrinsicWidth` , for inexpensive widgets.
- Extract `Icon` properties. So more customizable

## Additional information

- To contrib to this project, you can open a PR or an issue.

- Want to thank me? you can buy me a coffee

<a href="https://www.buymeacoffee.com/pmatatias"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=👨‍💻&slug=pmatatias&button_colour=5F7FFF&font_colour=ffffff&font_family=Inter&outline_colour=000000&coffee_colour=FFDD00" /></a>
