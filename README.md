# Input Quantity

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=dev.pmatatias.gnade&pcampaignid=web_share&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1" style="display: inline-block;">
    <img alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" height="90" style="vertical-align: middle;"/>
  </a>
</p>

<p align="center">
  <a href="https://pub.dev/packages/input_quantity">
    <img src="https://img.shields.io/pub/v/input_quantity.svg" alt="pub pkg">
  </a>
  <a href="https://pub.dev/packages/input_quantity/score">
    <img src="https://img.shields.io/pub/likes/input_quantity?logo=dart" alt="likes">
  </a>
  <a href="https://pub.dev/packages/input_quantity/score">
    <img src="https://img.shields.io/pub/popularity/input_quantity?logo=dart" alt="Popularity">
  </a>
  <a href="https://pub.dev/packages/input_quantity/score">
    <img src="https://img.shields.io/pub/points/input_quantity?logo=dart" alt="Pub points">
  </a>
  <a href="https://pub.dev/publishers/pmatatias.dev/packages">
    <img src="https://img.shields.io/pub/publisher/logo_n_spinner.svg" alt="Publisher">
  </a>
  <a href="https://github.com/pmatatias/input-quantity">
    <img src="https://img.shields.io/github/stars/pmatatias/input-quantity.svg?style=flat&logo=github&colorB=deepgreen&label=stars" alt="Star on Github">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/license-MIT-red.svg" alt="License: MIT">
  </a>
</p>

Flutter widget for quantity input. Increase or decrease the input value by pressing the button. It's built with text fields, so **InputQty** also supports manually typing quantities. Very flexible for large quantities. For example, if the user wants to enter the value `19243`, it will be very difficult to only rely on buttons.

Set input limits so that input values automatically return to predefined maximum/minimum values.

<p align="center">
  <img src="https://raw.githubusercontent.com/pmatatias/input-quantity/master/assets/demo_v2.gif" alt="Demo Preview" title="Demo Preview" />
</p>

## Features

- Simple and easy to use
- Customizable
- Output: `int`, `double`, or `num`
- Style options: classic, button on the left or button on the right
- Tap once to update the value, `longpress` for update the value continuously, or type the value manually.
- Add validator form, or use custom message builder

## Installation

To use this package, add `input_quantity` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  input_quantity: ^2.5.0
```

Then, run `flutter pub get` to install the package.

## Usage

### Basic Usage

```dart
import 'package:input_quantity/input_quantity.dart';

InputQty(
  maxVal: 100,
  initVal: 0,
  minVal: -100,
  steps: 10,
  onQtyChanged: (val) {
    print(val);
  },
)
```

### Typing Manually

If you want to prevent typing manually, you can disable it from `enableTyping`.

```dart
InputQty(
  qtyFormProps: QtyFormProps(enableTyping: false),
  ...
)
```

### Output Types

By default, the output will be as a `num`.

```dart
InputQty(
  onQtyChanged: (val) {
    print(val.runtimeType); // num
  },
)
```

To specify the output type as `int`:

```dart
InputQty.int(
  onQtyChanged: (val) {
    print(val.runtimeType); // int
  },
)
```

To specify the output type as `double`:

```dart
InputQty.double(
  onQtyChanged: (val) {
    print(val.runtimeType); // double
  },
)
```

### Customizing Appearance and Behavior

#### Using `QtyFormProps`

You can customize the appearance and behavior of the input field using `QtyFormProps`.

```dart
InputQty(
  qtyFormProps: QtyFormProps(
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold),
    cursorColor: Colors.red,
    enableTyping: true,
  ),
)
```

#### Using `QtyDecorationProps`

You can customize the decoration of the input field using `QtyDecorationProps`.

```dart
InputQty(
  decoration: QtyDecorationProps(
    borderShape: BorderShapeBtn.circle,
    btnColor: Colors.blue,
    fillColor: Colors.grey[200],
    isBordered: true,+
  ),
)
```

### Validation

You can use the `validator` property to validate the input value.

```dart
InputQty(
  validator: (value) {
    if (value == null) {
      return "Required field";
    } else if (value >= 200) {
      return "More than available quantity";
    }
    return null;
  },
)
```

### Custom Messages

You can use the `messageBuilder` property to display custom messages based on the input value.

```dart
InputQty(
  messageBuilder: (minVal, maxVal, value) {
    if (value == null) return null;
    if (value < -20) {
      return Text(
        "Reach my limit",
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      );
    } else if (value > 20) {
      return Text(
        "Reach my limit",
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Value : $value", textAlign: TextAlign.center);
    }
  },
)
```

### Controlling Input Value Programmatically

You can use `TextEditingController` to control the input value programmatically.

```dart
final TextEditingController _controller = TextEditingController();

InputQty(
  qtyFormProps: QtyFormProps(
    controller: _controller,
  ),
)
```

### Button Orientation

You can change the orientation of the buttons using `ButtonOrientation`.

```dart
InputQty(
  decoration: QtyDecorationProps(
    orientation: ButtonOrientation.horizontal,
  ),
)
```

### Button Position

You can change the position of the buttons using `QtyStyle`.

```dart
InputQty(
  decoration: QtyDecorationProps(
    qtyStyle: QtyStyle.btnOnRight,
  ),
)
```

## Examples

For more examples, check the [example](example) directory.

<p align="">
  <img src="https://raw.githubusercontent.com/pmatatias/input-quantity/master/assets/preview.png" alt="Image Preview" title="Image Preview" style="height:500px;" />
</p>

## Contributons

To contribute to this project, please follow the guidelines in the [CONTRIBUTING.md](CONTRIBUTING.md) file.

Thank you to all contributors for their valuable contributions!


<table align="center" style="border: none;">
  <tr>
    <td align="center"><a href="https://github.com/pmatatias"><img src="https://avatars.githubusercontent.com/u/33835308?v=4" width="50px;" alt="@pmatatias"/></a></td>
    <td align="center"><a href="https://github.com/tonypioneer"><img src="https://avatars.githubusercontent.com/u/128760989?v=4" width="50px;" alt="@tonypioneer"/></a></td>
    <td align="center"><a href="https://github.com/fixiply"><img src="https://avatars.githubusercontent.com/u/105910226?v=4" width="50px;" alt="@fixiply"/></a></td>
    <td align="center"><a href="https://github.com/sirfaman"><img src="https://avatars.githubusercontent.com/u/175967719?v=4" width="50px;" alt="@sirfaman"/></a></td>
  </tr>
</table>



## Additional Information

- Want to thank me? You can buy me a coffee.

<a href="https://www.buymeacoffee.com/pmatatias"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=👨‍💻&slug=pmatatias&button_colour=5F7FFF&font_colour=ffffff&font_family=Inter&outline_colour=000000&coffee_colour=FFDD00" /></a>

