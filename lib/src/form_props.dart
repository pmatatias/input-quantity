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
  /// if `false` Button and the  contoller will be disable.
  final bool? enabled;

  /// set to false if want to disable typing manuall
  /// and prevent pop up softkeyboard.
  /// only use button to increase/decrese the value
  final bool enableTyping;

  /// obsecure text
  final bool obscureText;

  /// character for obescure text
  final String obscuringCharacter;

  /// show or hide cursor
  final bool? showCursor;

  /// override text controller of textfield
  final TextEditingController? controller;

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
    this.enableTyping = true,
    this.cursorRadius,
    this.enabled,
    this.showCursor,
    this.controller,
  });
}
