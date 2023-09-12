import 'package:flutter/material.dart';
import 'package:input_quantity/src/constant.dart';
import '../input_quantity.dart';

class BuildBtn extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;
  final bool isPlus;
  final Color btnColor;
  final double? splashRadius;
  final BorderShapeBtn borderShape;
  final QtyStyle qtyStyle;

  const BuildBtn({
    super.key,
    this.splashRadius,
    this.borderShape = BorderShapeBtn.none,
    required this.isPlus,
    this.onTap,
    this.btnColor = Colors.teal,
    this.child,
    this.qtyStyle = QtyStyle.classic,
  });

  @override
  Widget build(BuildContext context) {
    switch (qtyStyle) {
      case QtyStyle.btnOnLeft:
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
            child: child ?? Icon(isPlus ? Icons.add : Icons.remove),
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
            child: child ?? Icon(isPlus ? Icons.add : Icons.remove),
          ),
        );
    }
  }
}
