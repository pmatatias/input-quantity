/// set border to the icon button
/// this property used only for icon. not the whole widget
enum BorderShapeBtn {
  /// no border applied to the icon
  none,

  /// apply border with circle shape
  circle,

  /// apply border with square shape
  square,
  //rhombus  // on development
}

enum QtyStyle {
  /// deftault style, with plus button on the right
  /// and minus button on the left side
  classic,

  /// both button will be wraped by column on the left side
  btnOnLeft,

  /// both button will be wraped by column on the right side
  btnOnRight
}

enum ButtonOrientation {
  /// Both botton will placed horizontally
  /// left and right side
  horizontal,

  /// Both botton will placed vertically
  /// top and bottom
  vertical
}
