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
  });

  @override
  Widget build(BuildContext context) {
    bool isCircleBorder = borderShape == BorderShapeBtn.circle;
    bool isSqborder = borderShape == BorderShapeBtn.square;
    switch (qtyStyle) {
      case QtyStyle.btnOnLeft:
        return InkWell(
          radius: 12,
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: isCircleBorder ? BoxShape.circle : BoxShape.rectangle,
                border: borderShape == BorderShapeBtn.none
                    ? null
                    : Border.all(color: btnColor, width: 1),
                borderRadius: isCircleBorder
                    ? null
                    : BorderRadius.only(
                        topLeft:
                            isPlus ? const Radius.circular(5) : Radius.zero,
                        bottomLeft:
                            isPlus ? Radius.zero : const Radius.circular(5))),
            child: child ??
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSqborder ? 8.0 : 2.0),
                  child: Icon(
                    isPlus ? Icons.add : Icons.remove,
                    size: 18,
                    color: btnColor,
                  ),
                ),
          ),
        );
      case QtyStyle.btnOnRight:
        return InkWell(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: isCircleBorder ? BoxShape.circle : BoxShape.rectangle,
              border: borderShape == BorderShapeBtn.none
                  ? null
                  : Border.all(color: btnColor, width: 1),
              borderRadius: isCircleBorder
                  ? null
                  : BorderRadius.only(
                      topRight: isPlus ? const Radius.circular(5) : Radius.zero,
                      bottomRight:
                          isPlus ? Radius.zero : const Radius.circular(5)),
            ),
            child: child ??
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isSqborder ? 8.0 : 2.0),
                  child: Icon(
                    isPlus ? Icons.add : Icons.remove,
                    size: 18,
                    color: btnColor,
                  ),
                ),
          ),
        );
      default:
        return InkWell(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: borderShape == BorderShapeBtn.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              border: borderShape == BorderShapeBtn.none
                  ? null
                  : Border.all(color: btnColor, width: 1),
            ),
            child: child ??
                Icon(
                  isPlus ? Icons.add : Icons.remove,
                  color: btnColor,
                ),
          ),
        );
    }
  }
}
