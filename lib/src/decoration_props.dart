import 'package:flutter/material.dart';

import '../input_quantity.dart';

class QtyDecorationProps {
  final MessageBuilder<num>? messageBuilder;
  // An icon to show before the input field and outside of the decoration's
  /// container.
  final Widget? icon;

  /// Defines minimum and maximum sizes for the [InputDecorator].
  final BoxConstraints? constraints;

  /// Icon widget for button plus
  final Widget? plusBtn;

  /// BoxConstraing for plus button widget
  final BoxConstraints? plusButtonConstrains;

  /// Icon widget for button minus
  final Widget? minusBtn;

  /// BoxConstraing for minus button widget
  final BoxConstraints? minusButtonConstrains;

  /// primary color applied on Button widget
  /// used when availabe to press
  final Color btnColor1;

  /// secondary color applied for button
  /// This value will used for disabled color button
  final Color btnColor2;

  /// define style widget
  final QtyStyle style;

  /// The shape of the border to draw around the decoration's container.
  ///
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [UnderlineInputBorder], which draws a horizontal line at the
  ///    bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [InputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  final InputBorder? border;

  /// The border to display when the [InputDecorator] does not have the focus and
  /// is showing an error.
  final InputBorder? errorBorder;

  /// The border to display when the [InputDecorator] has the focus and is not
  /// showing an error.
  final InputBorder? focusedBorder;

  /// The border to display when the [InputDecorator] is disabled and is not
  /// showing an error.
  final InputBorder? disabledBorder;

  /// The border to display when the [InputDecorator] is enabled and is not
  /// showing an error.
  final InputBorder? enabledBorder;

  /// The color of the highlight for the decoration shown if the container
  /// is being hovered over by a mouse.
  final Color? hoverColor;

  /// If true the decoration's container is filled with [fillColor].
  /// This property is false by default.
  final bool? filled;

  /// Whether the decoration is the same size as the input field.
  /// Defaults to true
  final bool isCollapsed;

  /// The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  /// Defaults to false.
  final bool? isDense;

  /// Optional text to place below the line as a character count.
  /// If null or an empty string and [counter] isn't specified, then nothing
  /// will appear in the counter's location.
  final String? counterText;

  /// Optional custom counter widget to go in the place otherwise occupied by
  /// [counterText]. If this property is non null, then [counterText] is
  /// ignored.
  final Widget? counter;

  /// Only one of [error] and [errorText] can be specified.
  final Widget? error;

  /// Only one of [error] and [errorText] can be specified.
  final String? errorText;

  const QtyDecorationProps({
    this.icon,
    this.messageBuilder,
    this.minusBtn,
    this.minusButtonConstrains = const BoxConstraints(),
    this.plusBtn,
    this.plusButtonConstrains = const BoxConstraints(),
    this.style = QtyStyle.classic,
    this.border,
    this.constraints,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.hoverColor,
    this.contentPadding,
    this.counter,
    this.counterText,
    this.error,
    this.errorText,
    this.filled,
    this.isCollapsed = true,
    this.isDense,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  });
}
