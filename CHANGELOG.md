## 2.0.1

- update screenshot picture

# 2.0.0

Sep 15, 2023 [#36](https://github.com/pmatatias/input-quantity/pull/36)

- Output can be specify: `int`,`double` or by default as `num`
- Add Feature longpress to update value
- Fix input unnecessary typing character
- Add new feature Validator and message builder
- Add and export more decoration for `TextFormField` and `InputDecoration` as `InputQty` property
- @Deprecated item is not removed yet, but set the value will not taking any effect. Most of property are moved into `QtyDecorationProps`.
  list of deprecated property :
  `showMessageLimit`, `textFieldDecoration`, `plusBtn`, `minusBtn`, `btnColor1`,`btnColor2`,`splashRadius`, `borderShape`.

## 1.2.4

Aug 30, 2023

- remove expired homepage site

## 1.2.3

Aug 8, 2023 [#26](https://github.com/pmatatias/input-quantity/pull/26)

- remove initial value change on initstate
- add `onTapOutside` property to dismiss soft keyboard

## 1.2.2

Aug 8, 2023 [#25](https://github.com/pmatatias/input-quantity/pull/25)

- fix `super.initState()` and `super.dispose()`

## 1.2.1

- doc: fix typo changelog

## 1.2.0

Jun 7, 2023 [#22](https://github.com/pmatatias/input-quantity/pull/22)

- refactor: separeted `BuildBtn` widget
- initial `borderShape = BorderShapeBtn.none`
- Use `BoxShape` insted of border radius on decoration

## 1.1.6

- upgrade sdk `>=2.17.3 <4.0.0`
- test: Run with dart 3.0 and flutter 3.10
- Add screenshoot info on `pubspec.yaml` file

## 1.1.5

- doc: update readme

## 1.1.4

- Fix : padding bottom on web version.

## 1.1.3

- feat: add message limit at the bottom of widget
- doc: fix change log 1.1.2

## 1.1.2

- doc: add width and heght to demo image

## 1.1.1

- doc: update image demo size

## 1.1.0

- release patch 5
- update demo image gif

## 1.1.0-dev (patch-5)

- valuenotifier for any changes value
- feat: autochange color when reach limit value top/bottom
- change color button
- border circle and border none of button
- custom widget or icon button
- fix: logic max and min value on steps
- add boxdecoration for reset border

## 1.0.1

- update image preview
- update description

## 1.0.0

- Release stable version
- Update documentation

## 1.0.0-beta.3

- Add comment description
- Extract Input Decoration from TextFromField
- fix keyboard for minus input
- add image preview

## 1.0.0-beta.2

- Add intrinsic and expanded size
- Update Documentation
- Add new example
- Add minVal property

## 1.0.0-beta

- Change data type to num
- Use ValueNotifier to avoid rebuild widget
- Fix typo documentation and pubspec.yaml
- Wrap with Intrinsic height
- upgrade sdk version to 3.3.2

## 0.0.1

- Initial relase Input quantity
