import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputQty extends StatefulWidget {
  /// maximum value input
  /// default  maxVal = num.maxFinite,
  final num maxVal;

  /// intial value
  /// default = 0
  final num initVal;

  /// minimum value
  /// default is 0
  final num minVal;

  /// steps increase and decrease
  /// defalult =1
  final num steps;

  /// Funnction(value) onChanged
  /// update value every changes
  final ValueChanged<num?> onQtyChanged;

  /// wrap [TextFormField] with [IntrinsicWidth] widget
  /// if `false` wrapped with [Expanded]
  final bool isIntrinsicWidth;

  const InputQty({
    Key? key,
    this.initVal = 0,
    this.isIntrinsicWidth = true,
    required this.onQtyChanged,
    this.maxVal = double.maxFinite,
    this.minVal = 0,
    this.steps = 1,
  }) : super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  /// text controller of textfield
  TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  /// late num value;
  late ValueNotifier<num> currentval;

  @override
  void initState() {
    // value = widget.initVal;
    currentval = ValueNotifier(widget.initVal);

    _valCtrl = TextEditingController(text: "${widget.initVal}");

    widget.onQtyChanged(num.tryParse(_valCtrl.text));
    super.initState();
  }

  /// Increase current value
  /// based on stpes
  /// default steps = 1
  void plus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    if (value < widget.maxVal) {
      value += widget.steps;
      currentval = ValueNotifier(value);
    } else {
      value = widget.maxVal;
      currentval = ValueNotifier(value);
    }

    /// set back to the controller
    _valCtrl.text = "$value";

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  /// decrese current value
  /// based on stpes
  /// default steps = 1
  void minus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    if (value > widget.minVal) {
      value -= widget.steps;
      currentval = ValueNotifier(value);
    } else {
      value = widget.minVal;
      currentval = ValueNotifier(value);
    }

    /// set back to the controller
    _valCtrl.text = "$value";

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return widget.isIntrinsicWidth
        ? IntrinsicWidth(child: _buildQtyInput())
        : _buildQtyInput();
  }

  /// build widget
  Widget _buildQtyInput() => Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.8),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: minus,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.remove,
                size: 16,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: _buildtextfield()),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              color: Colors.teal,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: plus,
              icon: const Icon(
                Icons.add,
                size: 16,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      );

  /// widget textformfield
  Widget _buildtextfield() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            isDense: true,
            isCollapsed: true,
          ),
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
            widget.onQtyChanged(num.tryParse(_valCtrl.text));
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _valCtrl.dispose();
  }
}
