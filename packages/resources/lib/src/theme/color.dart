part of 'theme.dart';

class _Color {
  factory _Color() => const _Color._(
        primary: _PrimaryColor(
          black: Color(0xFF000000),
          white: Color(0xFFEDEFE0),
          blue: Color(0xFF5038FF),
          periwinkle: Color(0xFFAAB9FF),
        ),
        secondary: _SecondaryColor(
          yellow: _Yellow(
            mellow: Color(0xFFFFFAC0),
            bright: Color(0xFFFFF700),
          ),
          bronze: Color(0xFFB0A600),
          peach: Color(0xFFFF8F87),
          orange: Color(0xFFFF4600),
          red: Color(0xFFA80700),
          darkGray: Color(0xFF8F8F8F),
          mostlyBlack: Color(0xFF292929),
          lightBlue: Color(0xFF5038FF),
          mostlyWhite: Color(0xFFF5F5F5),
          lightWhite: Color(0xFFFFFFFF),
          whisper: Color(0xFFE7E7E7),
          gainsboro: Color(0xFFDBDBDB),
          brightRed: Color(0xFFF43F5F),
          verylightGray: Color(0xFFE4E4E4),
          lightGray: Color(0xFFEBEBEB),
          gray: Color(0xFFB8B8B8),
          brightGray: Color(0xFFCCCCCC),
          pureBlue: Color(0xFF007AFF),
          mercury: Color(0xFFE5E5E5),
          doveGray: Color(0xFF666666),
          alabaster: Color(0xFFFCFCFC),
          sliver: Color(0xFFA3A3A3),
          buccaneer: Color(0xFF5F2C29),
          graySolid: Color(0xFF808080),
          boulder: Color(0xFF7A7A7A),
          whiteRock: Color(0xFFEDEFE0),
          gray52: Color(0xFF858585),
          gray87: Color(0xFFDEDEDE),
          matterhorn: Color(0xFF4D4C4C),
          whiteSmoke: Color(0xFFF9F9F9),
          gray18: Color(0xFF2E2E2E),
          graniteGray: Color(0xFF606060),
          ligthRed: Color(0xFFF6F6F6),
        ),
      );

  const _Color._({required this.primary, required this.secondary});

  final _PrimaryColor primary;
  final _SecondaryColor secondary;
}

class _PrimaryColor {
  const _PrimaryColor({
    required this.black,
    required this.white,
    required this.blue,
    required this.periwinkle,
  });

  final Color black;
  final Color white;
  final Color blue;
  final Color periwinkle;
}

class _SecondaryColor {
  const _SecondaryColor({
    required this.yellow,
    required this.bronze,
    required this.peach,
    required this.orange,
    required this.red,
    required this.darkGray,
    required this.mostlyBlack,
    required this.lightBlue,
    required this.mostlyWhite,
    required this.lightWhite,
    required this.whisper,
    required this.gainsboro,
    required this.brightRed,
    required this.verylightGray,
    required this.lightGray,
    required this.gray,
    required this.brightGray,
    required this.pureBlue,
    required this.doveGray,
    required this.alabaster,
    required this.sliver,
    required this.mercury,
    required this.buccaneer,
    required this.graySolid,
    required this.boulder,
    required this.whiteRock,
    required this.gray52,
    required this.gray87,
    required this.matterhorn,
    required this.whiteSmoke,
    required this.gray18,
    required this.graniteGray,
    required this.ligthRed,
  });

  final _Yellow yellow;
  final Color bronze;
  final Color peach;
  final Color orange;
  final Color red;
  final Color darkGray;
  final Color mostlyBlack;
  final Color lightBlue;
  final Color mostlyWhite;
  final Color lightWhite;
  final Color whisper;
  final Color gainsboro;
  final Color brightRed;
  final Color verylightGray;
  final Color lightGray;
  final Color gray;
  final Color brightGray;
  final Color pureBlue;
  final Color mercury;
  final Color doveGray;
  final Color alabaster;
  final Color sliver;
  final Color buccaneer;
  final Color graySolid;
  final Color boulder;
  final Color whiteRock;
  final Color gray52;
  final Color gray18;
  final Color gray87;
  final Color matterhorn;
  final Color whiteSmoke;
  final Color graniteGray;
  final Color ligthRed;
}

class _Yellow {
  const _Yellow({
    required this.mellow,
    required this.bright,
  });

  final Color mellow;
  final Color bright;
}
