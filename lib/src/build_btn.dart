import 'package:flutter/material.dart';
import 'package:input_quantity/src/constant.dart';
import '../input_quantity.dart';

class BuildBtn extends StatelessWidget {
  final Widget? child;
  final Function()? onPressed;
  final bool isPlus;
  final Color btnColor;
  final double? splashRadius;

  final BorderShapeBtn borderShape;

  const BuildBtn({
    super.key,
    this.splashRadius,
    this.borderShape = BorderShapeBtn.none,
    required this.isPlus,
    this.onPressed,
    this.btnColor = Colors.teal,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.amber,
        radius: 50,

        // splashFactory: InkRipple.splashFactory,
        // borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.all(1),
          // padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              shape: borderShape == BorderShapeBtn.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              border: borderShape == BorderShapeBtn.none
                  ? null
                  : Border.all(color: btnColor, width: 1),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(3))),
          child: child ?? Icon(isPlus ? Icons.add : Icons.remove, size: 16),
          // child: IconButton(
          //   color: btnColor,
          //   constraints: const BoxConstraints(),
          //   padding: EdgeInsets.zero,
          //   iconSize: 10,
          //   onPressed: onChanged,
          //   disabledColor: btnColor,
          //   splashRadius: splashRadius ?? 16,
          //   icon: child ?? Icon(isPlus ? Icons.add : Icons.remove, size: 16),
          // ),
        ),
      ),
    );
  }
}
