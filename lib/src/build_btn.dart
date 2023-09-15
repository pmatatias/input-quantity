import 'dart:async';

import 'package:flutter/material.dart';
import 'package:input_quantity/src/constant.dart';
import '../input_quantity.dart';

class BuildBtn extends StatelessWidget {
  /// icon widget
  final Widget? child;

  /// callback on tap
  final Function()? onTap;

  /// button plus or minus
  final bool isPlus;

  /// default button color
  final Color btnColor;

  /// shape border
  final BorderShapeBtn borderShape;

  /// start increasing value
  final void Function(Function? ontap) onStart;

  /// stop increasing value
  final VoidCallback onEndTime;

  /// widget style
  final QtyStyle qtyStyle;
  final Timer? time;
  const BuildBtn({
    super.key,
    this.borderShape = BorderShapeBtn.none,
    required this.isPlus,
    this.onTap,
    this.btnColor = Colors.teal,
    this.child,
    this.qtyStyle = QtyStyle.classic,
    this.time,
    required this.onEndTime,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    bool isCircleBorder = borderShape == BorderShapeBtn.circle;
    bool isSqborder = borderShape == BorderShapeBtn.square;
    switch (qtyStyle) {
      case QtyStyle.btnOnLeft:
        return GestureDetector(
          onLongPressStart: (details) => onStart.call(onTap),
          onLongPressEnd: (details) => onEndTime.call(),
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: isCircleBorder ? BoxShape.circle : BoxShape.rectangle,
                border: borderShape == BorderShapeBtn.none
                    ? null
                    : Border.all(
                        color: onTap == null ? Colors.grey : btnColor,
                        width: 1),
                borderRadius: isCircleBorder
                    ? null
                    : BorderRadius.only(
                        topLeft:
                            isPlus ? const Radius.circular(4) : Radius.zero,
                        bottomLeft:
                            isPlus ? Radius.zero : const Radius.circular(4))),
            child: child ??
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSqborder ? 8.0 : 2.0),
                  child: Icon(
                    isPlus ? Icons.add : Icons.remove,
                    size: 18,
                    color: onTap == null ? Colors.grey : btnColor,
                  ),
                ),
          ),
        );
      case QtyStyle.btnOnRight:
        return GestureDetector(
          onLongPressStart: (details) => onStart.call(onTap),
          onLongPressEnd: (details) => onEndTime.call(),
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: isCircleBorder ? BoxShape.circle : BoxShape.rectangle,
              border: borderShape == BorderShapeBtn.none
                  ? null
                  : Border.all(
                      color: onTap == null ? Colors.grey : btnColor, width: 1),
              borderRadius: isCircleBorder
                  ? null
                  : BorderRadius.only(
                      topRight: isPlus ? const Radius.circular(4) : Radius.zero,
                      bottomRight:
                          isPlus ? Radius.zero : const Radius.circular(4)),
            ),
            child: child ??
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSqborder ? 8.0 : 2.0),
                  child: Icon(
                    isPlus ? Icons.add : Icons.remove,
                    size: 18,
                    color: onTap == null ? Colors.grey : btnColor,
                  ),
                ),
          ),
        );
      default:
        return GestureDetector(
          onLongPressStart: (details) => onStart.call(onTap),
          onLongPressEnd: (details) => onEndTime.call(),
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: borderShape == BorderShapeBtn.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                border: borderShape == BorderShapeBtn.none
                    ? null
                    : Border.all(
                        color: onTap == null ? Colors.grey : btnColor,
                        width: 1),
                borderRadius: isCircleBorder
                    ? null
                    : BorderRadius.only(
                        topLeft:
                            isPlus ? Radius.zero : const Radius.circular(4),
                        bottomLeft:
                            isPlus ? Radius.zero : const Radius.circular(4),
                        topRight:
                            isPlus ? const Radius.circular(4) : Radius.zero,
                        bottomRight:
                            isPlus ? const Radius.circular(4) : Radius.zero)),
            child: child ??
                Icon(isPlus ? Icons.add : Icons.remove,
                    color: onTap == null ? Colors.grey : btnColor),
          ),
        );
    }
  }
}
