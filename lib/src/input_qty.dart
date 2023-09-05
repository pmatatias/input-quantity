import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_quantity/src/constant.dart';

import 'build_btn.dart';

class InputQty extends StatefulWidget {
  /// maximum value input
  /// default  `maxVal = num.maxFinite`,
  final num maxVal;

  /// intial value
  /// default `initVal = 1`
  /// To show decimal number, set `initVal` with decimal format
  /// eg: `initVal = 0.0`
  final num initVal;

  /// minimum value
  /// default `minVal = 0`
  final num minVal;

  /// steps increase and decrease
  /// defalult `steps = 1`
  /// also support for decimal steps
  /// eg: `steps = 3.14`
  final num steps;

  /// ```dart
  /// Function(num? value) onChanged
  /// ```
  /// update value every changes
  /// the `runType` is `num`. you may need to parse the data type
  /// parse to `int` : `value.toInt();`
  /// parse to `double` : `value.toDouble();`
  final ValueChanged<num?> onQtyChanged;

  /// wrap [TextFormField] with [IntrinsicWidth] widget
  /// this will make the width of [InputQty] set to intrinsic width
  /// default  `isIntrinsicWidth = true`
  /// if `false` wrapped with `Expanded`
  final bool isIntrinsicWidth;

  /// Icon widget for button plus
  final Widget? plusBtn;

  /// Icon widget for button minus
  final Widget? minusBtn;

  /// primary color applied on Button widget
  /// used when availabe to press
  final Color btnColor1;

  /// secondary color applied for button
  /// This value will used for disabled color button
  final Color btnColor2;

  /// spalsh radius effect
  /// show spalsh effect when the button are pressed
  final double? splashRadius;

  /// border shape of button
  /// - none,
  /// - circle,
  /// - square
  final BorderShapeBtn borderShape;

  ///boxdecoration
  ///use when you want to customize border
  ///around widget
  final BoxDecoration? boxDecoration;

  /// show message when the value reach the maximum or
  /// minimum value
  final bool showMessageLimit;

  /// Custom decoration of [TextFormField]
  /// default value:
  ///```dart
  /// const InputDecoration(
  ///  border: UnderlineInputBorder(),
  ///  isCollapsed: true,)
  ///```
  /// add [contentPadding] to costumize distance between value
  /// and the button
  final InputDecoration? textFieldDecoration;

  const InputQty({
    Key? key,
    this.initVal = 1,
    this.showMessageLimit = true,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.none,
    this.splashRadius,
    this.textFieldDecoration,
    this.isIntrinsicWidth = true,
    required this.onQtyChanged,
    this.maxVal = double.maxFinite,
    this.minVal = 0,
    this.plusBtn,
    this.minusBtn,
    this.steps = 1,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  }) : super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  /// text controller of textfield
  TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  /// late num value;
  late ValueNotifier<num?> currentval;

  @override
  void initState() {
    super.initState();
    currentval = ValueNotifier(widget.initVal);
    _valCtrl = TextEditingController(text: "${widget.initVal}");
  }

  /// Increase current value
  /// based on steps
  /// default [steps] = 1
  /// When the current value is empty string, and press [plus] button
  /// then firstly, it set the [value]= [initVal],
  /// after that [value] += [steps]
  void plus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    value += widget.steps;

    if (value >= widget.maxVal) {
      value = widget.maxVal;
    }

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  /// decrese current value based on stpes
  /// default [steps] = 1
  /// When the current [value] is empty string, and press [minus] button
  /// then firstly, it set the [value]= [initVal],
  /// after that [value] -= [steps]
  void minus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    value -= widget.steps;
    if (value <= widget.minVal) {
      value = widget.minVal;
    }

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return widget.isIntrinsicWidth
        ? IntrinsicWidth(child: _buildInputQty())
        : _buildInputQty();
  }

  /// build widget input quantity
  Widget _buildInputQty() => Container(
        alignment: Alignment.center,
        child: _buildtextfield(),
      );

  /// widget textformfield
  Widget _buildtextfield() => TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isCollapsed: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
            child: ValueListenableBuilder<num?>(
                valueListenable: currentval,
                builder: (context, value, child) {
                  bool limitBtmState =
                      (value ?? widget.initVal) > widget.minVal;
                  return BuildBtn(
                    btnColor:
                        limitBtmState ? widget.btnColor1 : widget.btnColor2,
                    isPlus: false,
                    borderShape: widget.borderShape,
                    splashRadius: widget.splashRadius,
                    onChanged: limitBtmState ? minus : null,
                    child: widget.minusBtn,
                  );
                }),
          ),
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
            child: ValueListenableBuilder<num?>(
                valueListenable: currentval,
                builder: (context, value, child) {
                  bool limitTopState =
                      (value ?? widget.initVal) < widget.maxVal;

                  return BuildBtn(
                    btnColor:
                        limitTopState ? widget.btnColor1 : widget.btnColor2,
                    isPlus: true,
                    borderShape: widget.borderShape,
                    onChanged: limitTopState ? plus : null,
                    splashRadius: widget.splashRadius,
                    child: widget.plusBtn,
                  );
                }),
          ),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: _valCtrl,
        onChanged: (String strVal) {
          num? temp = num.tryParse(_valCtrl.text);
          if (temp == null) return;
          if (temp > widget.maxVal) {
            temp = widget.maxVal;
            _valCtrl.text = "${widget.maxVal}";
            _valCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: _valCtrl.text.length));
          } else if (temp <= widget.minVal) {
            temp = widget.minVal;
            _valCtrl.text = temp.toString();
            _valCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: _valCtrl.text.length));
          }
          num? newVal = num.tryParse(_valCtrl.text);
          widget.onQtyChanged(newVal);
          currentval.value = newVal;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          // LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\-?\d*')),
        ],
      );

  // Widget _buildMsgLimit() => ValueListenableBuilder<num?>(
  //     valueListenable: currentval,
  //     builder: (context, val, __) {
  //       if (val == null) return const SizedBox();
  //       final value = val;
  //       if (value <= widget.minVal) {
  //         return Padding(
  //           padding: const EdgeInsets.only(top: 4),
  //           child: Text(
  //             'Min Val: ${widget.minVal}',
  //             style: const TextStyle(color: Colors.red),
  //           ),
  //         );
  //       } else if (value >= widget.maxVal) {
  //         return Padding(
  //           padding: const EdgeInsets.only(top: 4),
  //           child: Text(
  //             "Max Val: ${widget.maxVal}",
  //             style: const TextStyle(color: Colors.red),
  //           ),
  //         );
  //       } else {
  //         return const SizedBox();
  //       }
  //     });

  @override
  void dispose() {
    _valCtrl.dispose();
    super.dispose();
  }
}
