import 'package:flutter/material.dart';

import '../input_quantity.dart';

class QtyDecorationProps {
  /// border shape of button'
  /// - none,
  /// - circle,
  /// - square'
  final BorderShapeBtn borderShape;

  // An icon to show before the input field and outside of the decoration's
  /// container.
  final Widget? icon;

  /// The color of the [icon].
  ///
  /// If [iconColor] is a [MaterialStateColor], then the effective
  /// color can depend on the [MaterialState.focused] state, i.e.
  /// if the [InputQty] is focused or not.
  final Color? iconColor;

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
  final QtyStyle qtyStyle;

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

  /// set color when filled `true`
  final Color? fillColor;

  /// Whether the decoration is the same size as the input field.
  /// Defaults to true
  final bool isCollapsed;

  /// The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  /// Defaults to false.
  final bool? isDense;

  /// set border for InputQuantity widget
  ///
  /// default is true
  /// border decoration will be override if `InputBorder` are defined
  final bool isBordered;

  /// use for width of InputQty widget based on number of character
  /// default is `6`
  /// it will generate 6 character _ as hint text
  final int width;

  const QtyDecorationProps({
    this.icon,
    this.minusBtn,
    this.borderShape = BorderShapeBtn.none,
    this.minusButtonConstrains = const BoxConstraints(),
    this.plusBtn,
    this.plusButtonConstrains = const BoxConstraints(),
    this.qtyStyle = QtyStyle.classic,
    this.border,
    this.constraints,
    this.iconColor,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.hoverColor,
    this.width = 6,
    this.contentPadding,
    this.fillColor,
    this.filled,
    this.isCollapsed = true,
    this.isDense,
    this.isBordered = true,
    this.btnColor1 = Colors.green,
    this.btnColor2 = Colors.grey,
  });
}
