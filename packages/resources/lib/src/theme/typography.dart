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

TextTheme _textTheme = TextTheme(
  displayLarge: GoogleFonts.inter(
      fontSize: 32, fontWeight: FontWeight.normal, height: 1.25),
  displayMedium: GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.w500, height: 1.25),
  displaySmall: GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w500, height: 1.25),
  headlineMedium: GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w600, height: 1.25),
  headlineSmall: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, height: 1.25),
  titleLarge: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, height: 1.25),
  titleMedium: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w600, height: 1.25),
  titleSmall: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w600, height: 1.25),
  labelLarge:
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5),
  labelSmall:
      GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, height: 1.5),
);

extension TextThemeExtension on TextTheme {
  /// Merging with the corresponding default text styles to get the default properties like bodyColor, displayColor.
  TextStyle get body1Regular => bodyLarge!.merge(GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.normal, height: 1.5));

  TextStyle get body1Medium => bodyLarge!.merge(GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, height: 1.5));

  TextStyle get body1Bold => bodyLarge!.merge(GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold, height: 1.5));

  TextStyle get body2Regular => bodyMedium!.merge(GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.normal, height: 1.5));

  TextStyle get body2Medium => bodyMedium!.merge(GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, height: 1.5));

  TextStyle get body2Bold => bodyMedium!.merge(GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, height: 1.5));

  TextStyle get captionRegular => bodySmall!.merge(GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w400, height: 1.5));

  TextStyle get captionMedium => bodySmall!.merge(GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w600, height: 1.5));

  TextStyle get captionBold => bodySmall!.merge(GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.bold, height: 1.5));
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

class _Inter extends TextStyle {
  const _Inter({
    double? size,
    FontWeight? weight,
    super.height,
  }) : super(
          fontFamily: 'Inter',
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
