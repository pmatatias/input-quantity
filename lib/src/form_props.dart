import 'package:flutter/material.dart';

class QtyFormProps {
  /// align text horizontally
  final TextAlign textAlign;

  /// aling text, and icon widget vertically
  final TextAlignVertical textAlignVertical;

  /// styling  text
  final TextStyle? style;

  /// set type of keboard
  final TextInputType keyboardType;

  /// color for cursor
  final Color? cursorColor;

  /// height of the cursor
  final double? cursorHeight;

  /// animate opacity cursor
  final bool? cursorOpacityAnimates;

  /// cursor radius
  final Radius? cursorRadius;

  /// set width cursor
  final double cursorWidth;

  /// enabale qty formfield
  final bool? enabled;

  /// obsecure text
  final bool obscureText;

  /// character for obescure text
  final String obscuringCharacter;

  /// show or hide cursor
  final bool? showCursor;

  const QtyFormProps({
    this.textAlign = TextAlign.center,
    this.textAlignVertical = TextAlignVertical.center,
    this.keyboardType = TextInputType.number,
    this.style = const TextStyle(fontWeight: FontWeight.bold),
    this.cursorWidth = 2.0,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.cursorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.enabled,
    this.showCursor,
  });
}
