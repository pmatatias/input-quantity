import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BorderShapeBtn {
  none,
  circle,
  square,
  //rhombus  // on development
}

class InputQty extends StatefulWidget {
  /// maximum value input
  /// default  `maxVal = num.maxFinite`,
  final num maxVal;

  /// intial value
  /// default `initVal = 0`
  /// To show decimal number, set `initVal` with decimal format
  /// eg: `initVal = 0.0`
  ///
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
  /// the `runType` is `num`.
  /// parse to `int` : `value.toInt();`
  /// parse to `double` : `value.toDouble();`
  final ValueChanged<num?> onQtyChanged;

  /// wrap [TextFormField] with [IntrinsicWidth] widget
  /// this will make the width of [InputQty] set to intrinsic width
  /// default  `isIntrinsicWidth = true`
  /// if `false` wrapped with `Expanded`
  final bool isIntrinsicWidth;

  /// Custom decoration of [TextFormField]
  /// default value:
  ///```dart
  /// const InputDecoration(
  ///  border: UnderlineInputBorder(),
  ///  isDense: true,
  ///  isCollapsed: true,)
  ///```
  /// add [contentPadding] to costumize distance between value
  /// and the button
  final InputDecoration? textFieldDecoration;

  /// custom icon for button plus
  final Widget? plusBtn;

  /// Custom icon for button minus
  /// default size is 16
  final Widget? minusBtn;

  /// button color primary
  /// used when availabe to press
  final Color btnColor1;

  /// button color secondary
  /// used when not able to press
  final Color btnColor2;

  /// spalsh radius effect
  /// default = 16
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

  const InputQty({
    Key? key,
    this.initVal = 0,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.circle,
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

  /// [InputDecoration] use for [TextFormField]
  /// use when [textFieldDecoration] not null
  final _inputDecoration = const InputDecoration(
    border: UnderlineInputBorder(),
    isDense: true,
    isCollapsed: true,
  );
  @override
  void initState() {
    currentval = ValueNotifier(widget.initVal);
    _valCtrl = TextEditingController(text: "${widget.initVal}");
    widget.onQtyChanged(num.tryParse(_valCtrl.text));
    super.initState();
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
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        alignment: Alignment.center,
        decoration: widget.boxDecoration ??
            BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.8),
              borderRadius: BorderRadius.circular(5),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<num?>(
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
            const SizedBox(
              width: 8,
            ),
            Expanded(child: _buildtextfield()),
            const SizedBox(
              width: 8,
            ),
            ValueListenableBuilder<num?>(
                valueListenable: currentval,
                builder: (context, value, child) {
                  bool limitTopState =
                      (value ?? widget.initVal) < widget.maxVal;
                      print(limitTopState);
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
          ],
        ),
      );

  /// widget textformfield
  Widget _buildtextfield() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: widget.textFieldDecoration ?? _inputDecoration,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
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
            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\-?\d*")),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _valCtrl.dispose();
  }
}

class BuildBtn extends StatelessWidget {
  final Widget? child;
  final Function()? onChanged;
  final bool isPlus;
  final Color btnColor;
  final double? splashRadius;

  final BorderShapeBtn borderShape;

  const BuildBtn({
    super.key,
    this.splashRadius,
    this.borderShape = BorderShapeBtn.circle,
    required this.isPlus,
    this.onChanged,
    this.btnColor = Colors.teal,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    print(btnColor);
    return Container(
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: borderShape == BorderShapeBtn.none
            ? null
            : Border.all(color: btnColor),
        borderRadius: borderShape == BorderShapeBtn.circle
            ? BorderRadius.circular(9999)
            : null,
      ),
      child: IconButton(
        color: btnColor,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        onPressed: onChanged,
        disabledColor: btnColor,
        splashRadius: splashRadius ?? 16,
        icon: child ?? Icon(isPlus ? Icons.add : Icons.remove, size: 16),
      ),
    );
  }
}
