part of 'theme.dart';

// 100: Thin
// 200: ExtraLight
// 300: Light
// 400: Regular
// 500: Medium
// 600: SemiBold
// 700: Bold
// 800: ExtraBold
// 900: Black

TextTheme _textTheme = const TextTheme(
  headline1: _Arimo(size: 32, weight: FontWeight.normal, height: 1.25),
  headline2: _Arimo(size: 24, weight: FontWeight.w500, height: 1.25),
  headline3: _Arimo(size: 20, weight: FontWeight.w500, height: 1.25),
  headline4: _Arimo(size: 18, weight: FontWeight.w600, height: 1.25),
  headline5: _Arimo(size: 14, weight: FontWeight.bold, height: 1.25),
  headline6: _Arimo(size: 14, weight: FontWeight.bold, height: 1.25),
  subtitle1: _Arimo(size: 16, weight: FontWeight.w600, height: 1.25),
  subtitle2: _Arimo(size: 14, weight: FontWeight.w600, height: 1.25),
  button: _Arimo(size: 16, weight: FontWeight.w600, height: 1.5),
  overline: _Arimo(size: 11, weight: FontWeight.w500, height: 1.5),
);

extension TextThemeExtension on TextTheme {
  /// Merging with the corresponding default text styles to get the default properties like bodyColor, displayColor.
  TextStyle get body1Regular => bodyText1!
      .merge(const _Arimo(size: 16, weight: FontWeight.normal, height: 1.5));
  TextStyle get body1Medium => bodyText1!
      .merge(const _Arimo(size: 16, weight: FontWeight.w500, height: 1.5));
  TextStyle get body1Bold => bodyText1!
      .merge(const _Arimo(size: 16, weight: FontWeight.bold, height: 1.5));

  TextStyle get body2Regular => bodyText2!
      .merge(const _Arimo(size: 14, weight: FontWeight.normal, height: 1.5));
  TextStyle get body2Medium => bodyText2!
      .merge(const _Arimo(size: 14, weight: FontWeight.w500, height: 1.5));
  TextStyle get body2Bold => bodyText2!
      .merge(const _Arimo(size: 14, weight: FontWeight.bold, height: 1.5));

  TextStyle get captionRegular => caption!
      .merge(const _Arimo(size: 12, weight: FontWeight.w400, height: 1.5));
  TextStyle get captionMedium => caption!
      .merge(const _Arimo(size: 12, weight: FontWeight.w500, height: 1.5));
  TextStyle get captionBold => caption!
      .merge(const _Arimo(size: 12, weight: FontWeight.bold, height: 1.5));

}

class _Arimo extends TextStyle {
  const _Arimo({
    double? size,
    FontWeight? weight,
    super.height,
  }) : super(
    fontFamily: 'Arimo',
    fontSize: size,
    fontWeight: weight,
    package: 'resources',
  );
}

class _Telegraf extends TextStyle {
  const _Telegraf({
    double? size,
    FontWeight? weight,
    super.height,
  }) : super(
          fontFamily: 'Telegraf',
          fontSize: size,
          fontWeight: weight,
        );
}

class _SFPro extends TextStyle {
  const _SFPro({
    double? size,
    FontWeight? weight,
    super.height,
  }) : super(
          fontFamily: 'SFPro',
          fontSize: size,
          fontWeight: weight,
        );
}
