import 'package:flutter/material.dart';

part 'color.dart';
part 'typography.dart';

class AppTheme extends StatelessWidget {
  AppTheme({
    super.key,
    required this.brightness,
    required WidgetBuilder builder,
  })  : color = _Color(),
        child = Builder(builder: builder);

  final Brightness brightness;
  final Widget child;
  final _Color color;

  ThemeData get _lightTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: color.primary.black,
        secondary: color.primary.blue,
        tertiary: color.primary.periwinkle,
        surface: color.primary.white,
        onPrimary: color.primary.white,
        error: color.secondary.red,
      ),
      textTheme: _textTheme,
    ).copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: _textTheme.headline4!.copyWith(
          color: color.primary.black,
        ),
        iconTheme: IconThemeData(color: color.primary.black, size: 20),
        elevation: 0,
      ),
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: color.primary.white,
      ),
      snackBarTheme: _snackBarTheme,
      dividerColor: const Color(0xFFEBEBEB),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  ThemeData get _darkTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.dark(
        primary: color.primary.white,
        secondary: color.primary.blue,
        tertiary: color.primary.periwinkle,
        surface: color.primary.black,
        error: color.secondary.red,
      ),
      textTheme: _textTheme,
    ).copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: _textTheme.headline4!.copyWith(
          color: color.primary.white,
        ),
        iconTheme: IconThemeData(color: color.primary.white, size: 20),
        elevation: 0,
      ),
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: color.primary.periwinkle,
      ),
      snackBarTheme: _snackBarTheme,
      dividerColor: const Color(0xFF3D3D3D),
      scaffoldBackgroundColor: color.primary.black,
    );
  }

  final InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
  );

  final SnackBarThemeData _snackBarTheme = const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    shape: BeveledRectangleBorder(),
  );

  static AppTheme of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_AppThemeScope>();
    assert(scope != null, 'No ancestor of type "AppTheme" found.');

    return scope!.theme;
  }

  @override
  Widget build(BuildContext context) {
    return _AppThemeScope(theme: this, child: child);
  }

  ThemeData call({Brightness? brightness}) {
    final actualBrightness = brightness ?? this.brightness;

    if (actualBrightness == Brightness.light) return _lightTheme;
    return _darkTheme;
  }
}

class _AppThemeScope extends InheritedWidget {
  const _AppThemeScope({
    required this.theme,
    required super.child,
  });

  final AppTheme theme;

  @override
  bool updateShouldNotify(_AppThemeScope old) => old.theme() != theme();
}

extension AppThemeExtension on BuildContext {
  AppTheme get theme => AppTheme.of(this);

  ThemeData get themeData => theme();

  ColorScheme get colorScheme => themeData.colorScheme;

  TextTheme get textTheme => themeData.textTheme;

  _SecondaryColor get secondaryColor => theme.color.secondary;
}
