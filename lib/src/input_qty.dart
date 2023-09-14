// library input_quantity;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_quantity/src/constant.dart';
import 'package:input_quantity/src/decoration_props.dart';
import 'package:input_quantity/src/form_props.dart';

import 'build_btn.dart';

/// builder text widget under the InputQty
typedef MessageBuilder<T> = Widget Function(T minVal, T maxVal, T? value);

enum _OutputType { num, integer, double }

/// Widget to handle quantity input
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
  final ValueChanged? onQtyChanged;

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
  final _OutputType _outputType;

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
      'Use messageBuilder from QtyDecorationProps to specify message widget')
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

  /// Widget to handle quantity input
  ///
  /// for specific output, use `InputQty.int` or
  /// `InputQty.double`
  /// in not specify, the output will return as `num` type
  const InputQty({
    Key? key,
    this.initVal = 1,
    this.maxVal = double.maxFinite,
    this.minVal = 0,
    this.steps = 1,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.none,
    this.splashRadius,
    this.textFieldDecoration,
    this.plusBtn,
    this.minusBtn,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
    this.showMessageLimit = true,
  })  : _outputType = _OutputType.num,
        assert(!((validator != null) && (messageBuilder != null)),
            "Cant use `validator` and `messageBuilder` at the same time, please remove one of them"),
        super(key: key);

  /// Widget to handle quantity input
  ///
  /// output value from `onQtyChanged` will convert into `double`
  ///
  const InputQty.double({
    Key? key,
    this.initVal = 1.0,
    this.maxVal = double.maxFinite,
    this.minVal = 0.0,
    this.steps = 1.0,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    this.showMessageLimit = true,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.none,
    this.splashRadius,
    this.textFieldDecoration,
    this.plusBtn,
    this.minusBtn,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  })  : _outputType = _OutputType.double,

        /// cant use both property. choose only on
        assert(!((validator != null) && (messageBuilder != null)),
            "Cant use `validator` and `messageBuilder` at the same time, please remove one of them"),
        super(key: key);

  /// Widget to handle quantity input
  ///
  /// output value from `onQtyChanged` will convert into `int`
  const InputQty.int({
    Key? key,
    this.initVal = 1,
    this.maxVal = double.maxFinite,
    this.minVal = 0,
    this.steps = 1,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    this.showMessageLimit = true,
    this.boxDecoration,
    this.borderShape = BorderShapeBtn.none,
    this.splashRadius,
    this.textFieldDecoration,
    this.plusBtn,
    this.minusBtn,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  })  : _outputType = _OutputType.integer,

        /// cant use both property. choose only on
        assert(!((validator != null) && (messageBuilder != null)),
            "Cant use `validator` and `messageBuilder` at the same time, please remove one of them"),
        super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  /// text controller of textfield
  final TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  late ValueNotifier<num?> currentval;

  /// timer for  periodic call function
  Timer? timer;

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

    switch (widget._outputType) {
      case _OutputType.double:
        value = value.toDouble();
        break;
      case _OutputType.integer:
        value = value.toInt();
        break;

      default:
        value = value;
        break;
    }
    // value = widget._outputType ? value.toDouble() : value.toInt();

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;
    widget.onQtyChanged?.call(value);
  }

  /// start timer and chhange value
  void startTimer(Function? ontap) {
    ontap?.call();
    timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      ontap?.call();
    });
  }

  /// stop timer
  void endTimer() => timer?.cancel();

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
    switch (widget._outputType) {
      case _OutputType.double:
        value = value.toDouble();
        break;
      case _OutputType.integer:
        value = value.toInt();
        break;
      default:
        value = value;
        break;
    }

    /// set back to the controller
    _valCtrl.text = "$value";
    currentval.value = value;
    widget.onQtyChanged?.call(value);
  }

  /// setup decoration widget to textformfield
  InputDecoration decorationProps() {
    return InputDecoration(
      contentPadding: widget.decoration.contentPadding,
      // disabledBorder: widget.decoration.disabledBorder,
      // enabledBorder: widget.decoration.enabledBorder,
      // focusedBorder: widget.decoration.focusedBorder,
      errorBorder: widget.decoration.errorBorder,
      border: widget.decoration.border ??
          OutlineInputBorder(
              borderSide: widget.decoration.isBordered
                  ? const BorderSide()
                  : BorderSide.none),
      icon: widget.decoration.leadingWidget,
      isDense: widget.decoration.isDense,

      iconColor: widget.decoration.iconColor,
      counter: _buildMessageWidget(),
      fillColor: widget.decoration.fillColor,
      filled: widget.decoration.fillColor != null,
      isCollapsed: widget.decoration.isCollapsed,
      // hoverColor: widget.decoration.hoverColor,
      hintText: ''.padRight(widget.decoration.width, ' '),
      constraints: widget.decoration.constraints,
      prefixIcon: ValueListenableBuilder<num?>(
          valueListenable: currentval,
          builder: (context, value, child) {
            bool limitBtmState = (value ?? widget.initVal) > widget.minVal;
            bool limitTopState = (value ?? widget.initVal) < widget.maxVal;

            switch (widget.decoration.qtyStyle) {
              case QtyStyle.btnOnLeft:
                return Column(
                  children: [
                    BuildBtn(
                      isPlus: true,
                      borderShape: widget.decoration.borderShape,
                      onTap: limitTopState ? plus : null,
                      qtyStyle: widget.decoration.qtyStyle,
                      btnColor: widget.decoration.btnColor,
                      onStart: startTimer,
                      onEndTime: endTimer,
                      child: widget.decoration.plusBtn,
                    ),
                    BuildBtn(
                      isPlus: false,
                      borderShape: widget.decoration.borderShape,
                      onTap: limitBtmState ? minus : null,
                      btnColor: widget.decoration.btnColor,
                      qtyStyle: widget.decoration.qtyStyle,
                      onStart: startTimer,
                      onEndTime: endTimer,
                      child: widget.decoration.minusBtn,
                    ),
                  ],
                );
              case QtyStyle.btnOnRight:
                return const SizedBox();
              default:
                return BuildBtn(
                  isPlus: false,
                  qtyStyle: widget.decoration.qtyStyle,
                  borderShape: widget.decoration.borderShape,
                  btnColor: widget.decoration.btnColor,
                  onTap: limitBtmState ? minus : null,
                  onStart: startTimer,
                  onEndTime: endTimer,
                  child: widget.decoration.minusBtn,
                );
            }
          }),
      prefixIconConstraints: widget.decoration.minusButtonConstrains,
      suffixIconConstraints: widget.decoration.plusButtonConstrains,
      suffixIcon: ValueListenableBuilder<num?>(
          valueListenable: currentval,
          builder: (context, value, child) {
            bool limitBtmState = (value ?? widget.initVal) > widget.minVal;
            bool limitTopState = (value ?? widget.initVal) < widget.maxVal;

            switch (widget.decoration.qtyStyle) {
              case QtyStyle.btnOnRight:
                return Column(
                  children: [
                    BuildBtn(
                      isPlus: true,
                      borderShape: widget.decoration.borderShape,
                      btnColor: widget.decoration.btnColor,
                      qtyStyle: widget.decoration.qtyStyle,
                      onStart: startTimer,
                      onEndTime: endTimer,
                      onTap: limitTopState ? plus : null,
                      child: widget.decoration.plusBtn,
                    ),
                    // const SizedBox(height: 2),
                    BuildBtn(
                      isPlus: false,
                      borderShape: widget.decoration.borderShape,
                      onTap: limitBtmState ? minus : null,
                      btnColor: widget.decoration.btnColor,
                      onStart: startTimer,
                      onEndTime: endTimer,
                      qtyStyle: widget.decoration.qtyStyle,
                      child: widget.decoration.minusBtn,
                    ),
                  ],
                );
              case QtyStyle.btnOnLeft:
                return const SizedBox();
              default:
                return BuildBtn(
                  isPlus: true,
                  borderShape: widget.decoration.borderShape,
                  onTap: limitTopState ? plus : null,
                  btnColor: widget.decoration.btnColor,
                  onStart: startTimer,
                  onEndTime: endTimer,
                  qtyStyle: widget.decoration.qtyStyle,
                  child: widget.decoration.plusBtn,
                );
            }
          }),
    );
  }

  /// widget textformfield
  Widget _buildtextfield() => TextFormField(
        decoration: decorationProps(),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: _valCtrl,
        validator: widget.validator,
        textAlign: widget.qtyFormProps.textAlign,
        textAlignVertical: widget.qtyFormProps.textAlignVertical,
        style: widget.qtyFormProps.style,
        obscureText: widget.qtyFormProps.obscureText,
        obscuringCharacter: widget.qtyFormProps.obscuringCharacter,
        cursorColor: widget.qtyFormProps.cursorColor,
        cursorHeight: widget.qtyFormProps.cursorHeight,
        cursorOpacityAnimates: widget.qtyFormProps.cursorOpacityAnimates,
        cursorRadius: widget.qtyFormProps.cursorRadius,
        cursorWidth: widget.qtyFormProps.cursorWidth,
        keyboardType: widget.qtyFormProps.keyboardType,
        enabled: widget.qtyFormProps.enabled,
        showCursor: widget.qtyFormProps.showCursor,
        onChanged: (String strVal) {
          if (widget._outputType == _OutputType.integer &&
              strVal.contains('.')) {
            _valCtrl.text = '${currentval.value}';
            _valCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: _valCtrl.text.length));
            return;
          }
          // avoid parsing value
          if (strVal.isEmpty || strVal == '-') return;
          num? temp = num.tryParse(strVal);
          if (temp == null) {
            _valCtrl.text = '${currentval.value}';
            _valCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: _valCtrl.text.length));
            return;
          }
          switch (widget._outputType) {
            case _OutputType.double:
              temp = temp.toDouble();
              break;
            case _OutputType.integer:
              temp = temp.toInt();
              break;
            default:
              temp = temp;
              break;
          }
          // temp = temp.clamp(widget.minVal, widget.maxVal);
          // not using clamp, since need to update controller each limit
          if (temp >= widget.maxVal) {
            temp = widget.maxVal;

            _valCtrl.text = "$temp";
          } else if (temp < widget.minVal) {
            temp = widget.minVal;

            _valCtrl.text = "$temp";
          }
          widget.onQtyChanged?.call(temp);
          currentval.value = temp;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\-?\d*'))
        ],
      );

  /// build message widget
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
    currentval.dispose();
    super.dispose();
  }
}
