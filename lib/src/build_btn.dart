import 'package:flutter/material.dart';

import '../input_quantity.dart';

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
    return Container(
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: borderShape == BorderShapeBtn.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        border: borderShape == BorderShapeBtn.none
            ? null
            : Border.all(color: btnColor),
        // borderRadius: borderShape == BorderShapeBtn.circle
        //     ? BorderRadius.circular(9999)
        //     : null,
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
