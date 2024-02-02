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
  headline1: _Telegraf(size: 32, weight: FontWeight.normal, height: 1.25),
  headline2: _Telegraf(size: 24, weight: FontWeight.w500, height: 1.25),
  headline3: _Telegraf(size: 20, weight: FontWeight.w500, height: 1.25),
  headline4: _SFPro(size: 18, weight: FontWeight.w600, height: 1.25),
  headline5: _Telegraf(size: 14, weight: FontWeight.bold, height: 1.25),
  headline6: _SFPro(size: 14, weight: FontWeight.bold, height: 1.25),
  subtitle1: _SFPro(size: 16, weight: FontWeight.w600, height: 1.25),
  subtitle2: _SFPro(size: 14, weight: FontWeight.w600, height: 1.25),
  button: _SFPro(size: 16, weight: FontWeight.w600, height: 1.5),
  overline: _SFPro(size: 11, weight: FontWeight.w500, height: 1.5),
);

extension TextThemeExtension on TextTheme {
  /// Merging with the corresponding default text styles to get the default properties like bodyColor, displayColor.
  TextStyle get body1Regular => bodyText1!
      .merge(const _SFPro(size: 16, weight: FontWeight.normal, height: 1.5));
  TextStyle get body1Medium => bodyText1!
      .merge(const _SFPro(size: 16, weight: FontWeight.w500, height: 1.5));
  TextStyle get body1Bold => bodyText1!
      .merge(const _SFPro(size: 16, weight: FontWeight.bold, height: 1.5));

  TextStyle get body2Regular => bodyText2!
      .merge(const _SFPro(size: 14, weight: FontWeight.normal, height: 1.5));
  TextStyle get body2Medium => bodyText2!
      .merge(const _SFPro(size: 14, weight: FontWeight.w500, height: 1.5));
  TextStyle get body2Bold => bodyText2!
      .merge(const _SFPro(size: 14, weight: FontWeight.bold, height: 1.5));

  TextStyle get captionRegular => caption!
      .merge(const _SFPro(size: 12, weight: FontWeight.w400, height: 1.5));
  TextStyle get captionMedium => caption!
      .merge(const _SFPro(size: 12, weight: FontWeight.w500, height: 1.5));
  TextStyle get captionBold => caption!
      .merge(const _SFPro(size: 12, weight: FontWeight.bold, height: 1.5));

  /// For Credit Score
  TextStyle get creditScore =>
      const _Telegraf(size: 40, weight: FontWeight.w600);

  /// For high-priority currency values like Current Balance or payment amount.
  TextStyle get amount => const _SFPro(size: 32, weight: FontWeight.w500);

  /// Uppercase version of [overline].
  TextStyle get eyebrow => caption!
      .merge(const _SFPro(size: 11, weight: FontWeight.w600, height: 1.5));
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
