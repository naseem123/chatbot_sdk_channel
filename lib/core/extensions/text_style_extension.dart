import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get tn {
  return GoogleFonts.inter(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, height: 1.5),
  );
}

extension FontWeights on TextStyle {
  TextStyle get w1 => copyWith(fontWeight: FontWeight.w100);

  TextStyle get w6 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get wb => copyWith(fontWeight: FontWeight.bold);
}

extension Height on TextStyle {
  TextStyle h(double value) => copyWith(height: value);
}

extension FontStyles on TextStyle {
  TextStyle get b => copyWith(fontWeight: FontWeight.bold);

  TextStyle get u => copyWith(decoration: TextDecoration.underline);

  TextStyle get o => copyWith(decoration: TextDecoration.overline);

  TextStyle get i => copyWith(fontStyle: FontStyle.italic);

  TextStyle get lt => copyWith(decoration: TextDecoration.lineThrough);
}

extension TextColor on TextStyle {
  TextStyle c(Color? color) => copyWith(color: color);
}

extension TextSize on TextStyle {
  TextStyle get s12 => copyWith(fontSize: 12);

  TextStyle get s14 => copyWith(fontSize: 14);

  TextStyle get s16 => copyWith(fontSize: 16);

  TextStyle get s17 => copyWith(fontSize: 17);

  TextStyle get s18 => copyWith(fontSize: 18);

  TextStyle get s19 => copyWith(fontSize: 19);

  TextStyle get s20 => copyWith(fontSize: 20);
}
