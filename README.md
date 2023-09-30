# Input Quantity

[![pub package](https://img.shields.io/pub/v/input_quantity.svg)](https://pub.dev/packages/input_quantity)
[![likes](https://img.shields.io/pub/likes/input_quantity?logo=dart)](https://pub.dev/packages/input_quantity/score)
[![popularity](https://img.shields.io/pub/popularity/input_quantity?logo=dart)](https://pub.dev/packages/input_quantity/score)
[![pub points](https://img.shields.io/pub/points/input_quantity?logo=dart)](https://pub.dev/packages/input_quantity/score)
[![package publisher](https://img.shields.io/pub/publisher/logo_n_spinner.svg)](https://pub.dev/publishers/pmatatias.dev/packages)
<a href="https://github.com/pmatatias/input-quantity"><img src="https://img.shields.io/github/stars/pmatatias/input-quantity.svg?style=flat&logo=github&colorB=deepgreen&label=stars" alt="Star on Github"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-red.svg" alt="License: MIT"></a>

<!-- [![GitHub stars](https://img.shields.io/github/stars/pmatatias/input-quantity.svg?style=social)](https://github.com/pmatatias/input-quantity) -->

Flutter widget for quantity input. Increase or decrease the input value by pressing the button. It's built with text fields, so **InputQty** also supports manually typing quantities. Very flexible for large quantities. For example, if the user wants to enter the value `19243`, it will be very difficult to only rely on buttons.

Set input limits so that input values automatically return to predefined maximum/minimum values.
<p align="center">
 <img src="https://raw.githubusercontent.com/pmatatias/input-quantity/master/assets/demo_v2.gif" alt="img prev"  title="img prev">
</p>

## Features

- Simple and easy to use
- Customizeable
- Output: `int`,`double`, or `num`
- Style options: classic, button on the left or button on the right
- Tap once to update value, longpress for update value continuously, or type the value manually.
- Add validator form, or use custom message builder


## Usage

- example:

```dart
import 'package:input_quantity/input_quantity.dart';
...
  InputQty(
    maxVal: 100,
    initVal: 0,
    minVal: -100,
    steps: 10,
    onQtyChanged: (val) {
      print(val);
    },
  ),
```

---
- if you want to prevent type manual, you can disable it from `enableTyping`
```
InputQty(
  qtyFormProps: QtyFormProps(enableTyping: false),
)
```

---


- Output
By default, the output will be as a `num`. 
```
InputQty(
  onQtyChanged: (val) {
      print(val.runType);// num
    },
)
```

in the v1, we need to parse the output back to int or double inside onchange. Now from v2, you can specify the output.

as `int`
```
InputQty.int(
  onQtyChanged: (val) {
      print(val.runType);// int
    },
)
```

or as `double`
```
InputQty.double(
  onQtyChanged: (val) {
      print(val.runType);// double
    },
)
```

---

- Position of button
by default it will set as `classic` mode. Which is the plus button on the right and minus button on the left
```
InputQty(
   decoration: const QtyDecorationProps(
          qtyStyle: QtyStyle.classic
   )
)
```

Put the button on the left :
```
InputQty(
   decoration: const QtyDecorationProps(
          qtyStyle: QtyStyle.btnOnLeft
   )
)
```

last choice, on the right side
```
InputQty(
   decoration: const QtyDecorationProps(
          qtyStyle: QtyStyle.btnOnRight
   )
)
```

**For others example styling, you may check on the example page**


## To Do

- Add more documentation
- Splash effect
- Export icon decoration
- Add more example

## Additional information

- To contrib to this project, you can open a PR or an issue.

- Want to thank me? you can buy me a coffee

<a href="https://www.buymeacoffee.com/pmatatias"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=👨‍💻&slug=pmatatias&button_colour=5F7FFF&font_colour=ffffff&font_family=Inter&outline_colour=000000&coffee_colour=FFDD00" /></a>
