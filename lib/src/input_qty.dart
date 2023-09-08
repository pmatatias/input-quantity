// library input_quantity;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_quantity/src/constant.dart';
import 'package:input_quantity/src/decoration_props.dart';
import 'package:input_quantity/src/form_props.dart';

import 'build_btn.dart';

/// builder text widget under the InputQty
typedef MessageBuilder<T> = Widget Function(T minVal, T maxVal, T? value);

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
  final ValueChanged onQtyChanged;

  /// wrap [TextFormField] with [IntrinsicWidth] widget
  /// this will make the width of [InputQty] set to intrinsic width
  /// default  `isIntrinsicWidth = true`
  /// if `false` wrapped with `Expanded`
  final bool isIntrinsicWidth;

  ///boxdecoration
  ///use when you want to customize border
  ///around widget
  final BoxDecoration? boxDecoration;

  /// if `true` use value as double
  final bool _isDecimal;

  /// decoration property for input quantity
  final QtyDecorationProps decoration;

  /// validator
  final String? Function(String?)? validator;

  /// property for input quantity widget
  final QtyFormProps qtyFormProps;

  /// Widget for display text below the input quantity widget
  /// set into counter text with aling center
  /// only displayed if `validator` is null
  final MessageBuilder<num>? messageBuilder;

  @Deprecated(
      'Use messageBuilder from QtyDecorationProps to specify message widget'
      'If null, no message will displayed')
  final bool showMessageLimit;

  @Deprecated('Use QtyDecorationProps instead')
  final InputDecoration? textFieldDecoration;

  /// Icon widget for button plus
  @Deprecated('Use inside QtyDecorationProps instead')
  final Widget? plusBtn;

  /// Icon widget for button minus
  @Deprecated('Use inside QtyDecorationProps instead')
  final Widget? minusBtn;

  /// primary color applied on Button widget
  /// used when availabe to press
  @Deprecated('Use inside QtyDecorationProps instead')
  final Color btnColor1;

  /// secondary color applied for button
  /// This value will used for disabled color button
  @Deprecated('Use inside QtyDecorationProps instead')
  final Color btnColor2;

  /// spalsh radius effect
  /// show spalsh effect when the button are pressed
  @Deprecated('Use inside QtyDecorationProps instead')
  final double? splashRadius;

  @Deprecated('Use inside QtyDecorationProps instead')
  final BorderShapeBtn borderShape;

  const InputQty(
      {Key? key,
      this.initVal = 1,
      this.messageBuilder,
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
      this.validator,
      this.decoration = const QtyDecorationProps(),
      this.qtyFormProps = const QtyFormProps()})
      : _isDecimal = false,
        assert((validator == null) || (messageBuilder == null)),
        super(key: key);

  const InputQty.double({
    Key? key,
    this.initVal = 1.0,
    this.showMessageLimit = true,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.none,
    this.splashRadius,
    this.textFieldDecoration,
    this.messageBuilder,
    this.isIntrinsicWidth = true,
    required this.onQtyChanged,
    this.maxVal = double.maxFinite,
    this.minVal = 0.0,
    this.plusBtn,
    this.validator,
    this.minusBtn,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.steps = 1.0,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  })  : _isDecimal = true,

        /// can use both property. choose only on
        assert(!(validator == null) || (messageBuilder == null)),
        super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  /// text controller of textfield
  final TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  late ValueNotifier<num?> currentval;

  @override
  void initState() {
    super.initState();
    currentval = ValueNotifier(widget.initVal);
    _valCtrl.text = "${widget.initVal}";
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
    value = widget._isDecimal ? value.toDouble() : value.toInt();

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;
    widget.onQtyChanged(value);
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
    value = widget._isDecimal ? value.toDouble() : value.toInt();

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;
    widget.onQtyChanged(value);
  }

  InputDecoration decorationProps() {
    return InputDecoration(
      contentPadding: widget.decoration.contentPadding,
      disabledBorder: widget.decoration.disabledBorder,
      enabledBorder: widget.decoration.enabledBorder,
      errorBorder: widget.decoration.errorBorder,
      focusedBorder: widget.decoration.focusedBorder,
      icon: widget.decoration.icon,
      isDense: widget.decoration.isDense,
      iconColor: widget.decoration.iconColor,
      counter: _buildMessageWidget(),
      fillColor: widget.decoration.fillColor,
      filled: widget.decoration.filled,
      border: widget.decoration.border,
      isCollapsed: widget.decoration.isCollapsed,
      hoverColor: widget.decoration.hoverColor,
      hintText: ''.padRight(widget.decoration.width, '_'),
      constraints: widget.decoration.constraints,
      prefixIcon: ValueListenableBuilder<num?>(
          valueListenable: currentval,
          builder: (context, value, child) {
            bool limitBtmState = (value ?? widget.initVal) > widget.minVal;
            return BuildBtn(
              // btnColor: limitBtmState ? widget.btnColor1 : widget.btnColor2,
              // splashRadius: widget.splashRadius,
              isPlus: false,
              borderShape: widget.decoration.borderShape,
              onChanged: limitBtmState ? minus : null,
              child: widget.decoration.minusBtn,
            );
          }),
      prefixIconConstraints: widget.decoration.minusButtonConstrains,
      suffixIconConstraints: widget.decoration.plusButtonConstrains,
      suffixIcon: ValueListenableBuilder<num?>(
          valueListenable: currentval,
          builder: (context, value, child) {
            bool limitTopState = (value ?? widget.initVal) < widget.maxVal;
            return BuildBtn(
              // btnColor: limitTopState ? widget.btnColor1 : widget.btnColor2,
              // splashRadius: widget.splashRadius,
              isPlus: true,
              borderShape: widget.decoration.borderShape,
              onChanged: limitTopState ? plus : null,
              child: widget.decoration.plusBtn,
            );
          }),
    );
  }

  /// widget textformfield
  Widget _buildtextfield() => TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: decorationProps(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: _valCtrl,
        validator: (value) => "sadads",
        onChanged: (String strVal) {
          // avoid parsing value
          if (strVal.isEmpty || strVal == '-') return;
          num? temp = num.tryParse(strVal);
          if (temp == null) return;
          temp = widget._isDecimal ? temp.toDouble() : temp.toInt();
          // temp = temp.clamp(widget.minVal, widget.maxVal);

          // not using clamp, since need to update controller each limit
          if (temp >= widget.maxVal) {
            temp = widget.maxVal;
            _valCtrl.text = "$temp";
          } else if (temp <= widget.minVal) {
            temp = widget.maxVal;
            _valCtrl.text = "$temp";
          }
          widget.onQtyChanged(temp);
          currentval.value = temp;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\-?\d*'))
          // widget._isDecimal
          //     ? FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\-?\d*'))
          //     : FilteringTextInputFormatter.allow(RegExp(r'^\d*\-?\d*')),
        ],
      );

  Widget? _buildMessageWidget() => ValueListenableBuilder<num?>(
      valueListenable: currentval,
      builder: (context, val, __) {
        return Center(
          child: widget.messageBuilder?.call(widget.maxVal, widget.minVal, val),
        );
      });

  @override
  Widget build(BuildContext context) {
    return widget.isIntrinsicWidth
        ? IntrinsicWidth(child: _buildtextfield())
        : _buildtextfield();
  }

  @override
  void dispose() {
    _valCtrl.dispose();
    super.dispose();
  }
}
