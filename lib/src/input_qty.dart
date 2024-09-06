// library input_quantity;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_quantity/src/floating_point.dart';
import 'package:input_quantity/src/constant.dart';
import 'package:input_quantity/src/decoration_props.dart';
import 'package:input_quantity/src/form_props.dart';

import 'build_btn.dart';

/// builder text widget under the InputQty
typedef MessageBuilder<T> = Widget? Function(T minVal, T maxVal, T? value);

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

  /// if `true` use value as double
  final _OutputType _outputType;

  /// decoration property for input quantity
  final QtyDecorationProps decoration;

  /// validator
  final String? Function(num? value)? validator;

  /// property for input quantity widget
  final QtyFormProps qtyFormProps;

  /// Widget for display text below the input quantity widget
  /// set into counter text with aling center
  /// only displayed if `validator` is null
  final MessageBuilder<num>? messageBuilder;

  /// In Dart, the double type follows the IEEE 754 standard for floating-point representation, which uses a 64-bit format.
  /// The double type in Dart has a precision of about 15 to 17 decimal places.
  /// This means that operations involving double values may lose precision beyond the 15th to 17th decimal place.
  ///
  /// this value will use to limit number of decimal places
  final int decimalPlaces;

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
    this.decimalPlaces = 18,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    @Deprecated('Use QtyDecorationProps instead') BoxDecoration? boxDecoration,
    @Deprecated('Use inside QtyDecorationProps instead')
    BorderShapeBtn borderShape = BorderShapeBtn.none,
    @Deprecated('Use  QtyDecorationProps instead') double? splashRadius,
    @Deprecated('Use QtyFormProps instead')
    InputDecoration? textFieldDecoration,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? plusBtn,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? minusBtn,
    @Deprecated('Use inside QtyDecorationProps instead')
    Color btnColor1 = Colors.green,
    @Deprecated('Removed') Color btnColor2 = Colors.grey,
    @Deprecated(
        'Use messageBuilder from QtyDecorationProps to specify message widget'
        'This feature was deprecated after v2.0.0')
    bool showMessageLimit = false,
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
    this.decimalPlaces = 18,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    @Deprecated(
        'Use messageBuilder from QtyDecorationProps to specify message widget'
        'This feature was deprecated after v2.0.0')
    bool showMessageLimit = false,
    @Deprecated('Use QtyDecorationProps instead') BoxDecoration? boxDecoration,
    @Deprecated('Use inside QtyDecorationProps instead')
    BorderShapeBtn borderShape = BorderShapeBtn.none,
    @Deprecated('Use inside QtyDecorationProps instead') double? splashRadius,
    @Deprecated('Use QtyFormProps instead')
    InputDecoration? textFieldDecoration,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? plusBtn,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? minusBtn,
    @Deprecated('Use inside QtyDecorationProps instead')
    Color btnColor1 = Colors.green,
    @Deprecated('Removed') Color btnColor2 = Colors.grey,
  })  : _outputType = _OutputType.double,

        /// cant use both property. choose only one
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
    this.decimalPlaces = 0,
    this.onQtyChanged,
    this.messageBuilder,
    this.validator,
    this.decoration = const QtyDecorationProps(),
    this.qtyFormProps = const QtyFormProps(),
    this.isIntrinsicWidth = true,
    @Deprecated(
        'Use messageBuilder from QtyDecorationProps to specify message widget'
        'This feature was deprecated after v2.0.0')
    bool showMessageLimit = false,
    @Deprecated('Use QtyDecorationProps instead') BoxDecoration? boxDecoration,
    @Deprecated('Use inside QtyDecorationProps instead')
    BorderShapeBtn borderShape = BorderShapeBtn.none,
    @Deprecated('Use inside QtyDecorationProps instead') double? splashRadius,
    @Deprecated('Use QtyFormProps instead')
    InputDecoration? textFieldDecoration,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? plusBtn,
    @Deprecated('Use inside QtyDecorationProps instead') Widget? minusBtn,
    @Deprecated('Use inside QtyDecorationProps instead')
    Color btnColor1 = Colors.green,
    @Deprecated('Removed') Color btnColor2 = Colors.grey,
  })  : _outputType = _OutputType.integer,

        /// cant use both property. choose only one
        assert(!((validator != null) && (messageBuilder != null)),
            "Cant use `validator` and `messageBuilder` at the same time, please remove one of them"),
        super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  /// text controller of textfield
  late TextEditingController _valCtrl;

  /// current value of quantity
  late ValueNotifier<num?> currentval;

  /// timer for  periodic call function
  Timer? timer;

  /// decimal place steps
  int stepDecimalPlace = 0;

  @override
  void initState() {
    super.initState();
    currentval = ValueNotifier(widget.initVal);
    _valCtrl = widget.qtyFormProps.controller ?? TextEditingController();
    _valCtrl.text = "${widget.initVal}";
    if (widget._outputType != _OutputType.integer) {
      stepDecimalPlace = countDecimalPlaces(widget.steps);
    }
  }

  /// Increase current value
  /// based on steps
  /// default [steps] = 1
  /// When the current value is empty string, and press [plus] button
  /// then firstly, it set the [value]= [initVal],
  /// after that [value] += [steps]
  void plus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    int decimalpl = 0;
    if (widget._outputType == _OutputType.integer) {
      value += widget.steps;
    } else {
      int precision = max(countDecimalPlaces(value), stepDecimalPlace);
      value = addWithPrecision(value, widget.steps, precision);
      decimalpl = min(widget.decimalPlaces, precision);
    }
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

    /// set back to the controller
    _valCtrl.text = value.toStringAsFixed(decimalpl);
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
    // value -= widget.steps;
    int decimalpl = 0;

    if (widget._outputType == _OutputType.integer) {
      value -= widget.steps;
    } else {
      int precision = max(countDecimalPlaces(value), stepDecimalPlace);
      value = redWithPrecision(value, widget.steps, precision);
      decimalpl = min(widget.decimalPlaces, precision);
    }

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
    _valCtrl.text = value.toStringAsFixed(decimalpl);
    currentval.value = value;
    widget.onQtyChanged?.call(value);
  }

  /// check value is within range of minVal and maxVal
  void checkValue() {
    num? temp = num.tryParse(_valCtrl.text);
    if (temp != null) {
      if (temp >= widget.maxVal) {
        temp = widget.maxVal;

        _valCtrl.text = "$temp";
      } else if (temp < widget.minVal) {
        temp = widget.minVal;

        _valCtrl.text = "$temp";
      }
    } else {
      temp = widget.initVal;

      _valCtrl.text = "$temp";
    }
    widget.onQtyChanged?.call(temp);
    currentval.value = temp;
  }

  /// setup decoration widget to textformfield
  InputDecoration decorationProps() {
    final defaultBorder = widget.decoration.border ??
        OutlineInputBorder(
            borderSide: widget.decoration.isBordered
                ? const BorderSide()
                : BorderSide.none);
    return InputDecoration(
      contentPadding: widget.decoration.contentPadding,
      disabledBorder: widget.decoration.disabledBorder ??
          defaultBorder.copyWith(
              borderSide: defaultBorder.borderSide.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.38))),
      enabledBorder: widget.decoration.enabledBorder ?? defaultBorder,
      focusedBorder: widget.decoration.focusedBorder ?? defaultBorder,
      focusedErrorBorder:
          widget.decoration.focusedErrorBorder ?? widget.decoration.errorBorder,
      errorBorder: widget.decoration.errorBorder,
      border: defaultBorder,
      icon: widget.decoration.leadingWidget,
      isDense: widget.decoration.isDense,
      iconColor: widget.decoration.iconColor,
      counter: widget.messageBuilder != null ? _buildMessageWidget() : null,
      errorMaxLines: 2,
      fillColor: widget.decoration.fillColor,
      filled: widget.decoration.fillColor != null,
      isCollapsed: widget.decoration.isCollapsed,
      hintText: ''.padRight(widget.decoration.width, ' '),
      constraints: widget.decoration.constraints,
      prefixIcon: ValueListenableBuilder<num?>(
          valueListenable: currentval,
          builder: (context, value, child) {
            bool limitBtmState = (value ?? widget.initVal) > widget.minVal;
            bool limitTopState = (value ?? widget.initVal) < widget.maxVal;

            switch (widget.decoration.qtyStyle) {
              case QtyStyle.btnOnLeft:
                final childbtn = [
                  BuildBtn(
                    isPlus: true,
                    borderShape: widget.decoration.borderShape,
                    onTap: limitTopState ? plus : null,
                    qtyStyle: widget.decoration.qtyStyle,
                    btnColor: widget.decoration.btnColor,
                    onStart: startTimer,
                    onEndTime: endTimer,
                    orientation: widget.decoration.orientation,
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
                    orientation: widget.decoration.orientation,
                    child: widget.decoration.minusBtn,
                  ),
                ];
                return widget.decoration.orientation ==
                        ButtonOrientation.horizontal
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: childbtn.reversed.toList())
                    : Column(
                        mainAxisSize: MainAxisSize.min, children: childbtn);
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
                  orientation: widget.decoration.orientation,
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
                final childbtn = [
                  BuildBtn(
                    isPlus: true,
                    borderShape: widget.decoration.borderShape,
                    btnColor: widget.decoration.btnColor,
                    qtyStyle: widget.decoration.qtyStyle,
                    onStart: startTimer,
                    orientation: widget.decoration.orientation,
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
                    orientation: widget.decoration.orientation,
                    onEndTime: endTimer,
                    qtyStyle: widget.decoration.qtyStyle,
                    child: widget.decoration.minusBtn,
                  ),
                ];
                return widget.decoration.orientation ==
                        ButtonOrientation.horizontal
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: childbtn.reversed.toList())
                    : Column(
                        mainAxisSize: MainAxisSize.min, children: childbtn);
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
                  orientation: widget.decoration.orientation,
                  child: widget.decoration.plusBtn,
                );
            }
          }),
    );
  }

  /// widget textformfield
  Widget _buildtextfield() => TextFormField(
        decoration: decorationProps(),
        onTapOutside: (event) {
          checkValue();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: _valCtrl,
        readOnly: !widget.qtyFormProps.enableTyping,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) => widget.validator?.call(num.tryParse(val ?? '')),
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
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
        ],
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
        },
        onFieldSubmitted: (_) => checkValue(),
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
