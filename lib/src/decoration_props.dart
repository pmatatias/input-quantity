import 'package:flutter/material.dart';

class QtyDecorationProps {
  // An icon to show before the input field and outside of the decoration's
  /// container.
  final Widget? icon;

  final BoxConstraints? plusButtonConstrains;

  final BoxConstraints? minusButtonConstrains;

  /// Icon widget for button plus
  final Widget? plusBtn;

  /// Icon widget for button minus
  final Widget? minusBtn;

  const QtyDecorationProps({
    this.icon,
    this.minusBtn,
    this.minusButtonConstrains = const BoxConstraints(),
    this.plusBtn,
    this.plusButtonConstrains = const BoxConstraints(),
  });
}
