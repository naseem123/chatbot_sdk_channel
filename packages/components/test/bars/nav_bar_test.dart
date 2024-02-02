import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('nav bar test', () {
    group('light mode', () {
      testWidgets('divider = true', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.light,
            high: false,
            hasDivider: true,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/light_mode/divider_true.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xffffffff));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, Colors.black);
        expect(appBarTextWidget.text.style!.fontFamily, 'SFPro');
      });
      testWidgets('divider = false', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.light,
            high: false,
            hasDivider: false,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/light_mode/divider_false.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xffffffff));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, Colors.black);
        expect(appBarTextWidget.text.style!.fontFamily, 'SFPro');
      });
      testWidgets('divider = false, high', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.light,
            high: true,
            hasDivider: false,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/light_mode/divider_high.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xffffffff));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, Colors.black);
        expect(appBarTextWidget.text.style!.fontFamily, 'Telegraf');
      });
    });
    group('dark mode', () {
      testWidgets('divider = true', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.dark,
            high: false,
            hasDivider: true,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/dark_mode/divider_true.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xff000000));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, const Color(0xffedefe0));
        expect(appBarTextWidget.text.style!.fontFamily, 'SFPro');
      });

      testWidgets('divider = false', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.dark,
            high: false,
            hasDivider: false,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/dark_mode/divider_false.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xff000000));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, const Color(0xffedefe0));
        expect(appBarTextWidget.text.style!.fontFamily, 'SFPro');
      });

      testWidgets('divider = false, high', (WidgetTester tester) async {
        await tester.pumpWidget(
          const _NavBarTest(
            brightness: Brightness.dark,
            high: true,
            hasDivider: false,
          ),
        );
        await tester.pumpAndSettle();

        final appBarFinder = find.byType(AppBar);
        await expectLater(
          appBarFinder,
          matchesGoldenFile('goldens/nav_bar/dark_mode/divider_high.png'),
        );

        final materialFinder = find.byType(Material);

        final appBarMaterialFinder =
            find.descendant(of: appBarFinder, matching: materialFinder);
        final appBarMaterialWidget =
            tester.widget<Material>(appBarMaterialFinder);
        expect(appBarMaterialWidget.color, const Color(0xff000000));

        final textFinder = find.byType(RichText);
        final appBarTextFinder = find.descendant(
          of: appBarFinder,
          matching: textFinder,
        );
        expect(appBarTextFinder, findsOneWidget);
        final appBarTextWidget = tester.widget<RichText>(appBarTextFinder);
        expect(appBarTextWidget.text.toPlainText(), 'nav title');
        expect(appBarTextWidget.text.style!.color, const Color(0xffedefe0));
        expect(appBarTextWidget.text.style!.fontFamily, 'Telegraf');
      });
    });
  });
}

class _NavBarTest extends StatelessWidget {
  const _NavBarTest({
    required this.brightness,
    required this.high,
    required this.hasDivider,
  });

  final Brightness brightness;
  final bool high;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return high
        ? AppTheme(
            brightness: brightness,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  child: const NavBar.high(
                    title: Text(
                      'nav title',
                    ),
                  ),
                ),
              );
            },
          )
        : AppTheme(
            brightness: brightness,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  child: hasDivider
                      ? const NavBar(
                          hasDivider: true,
                          title: Text(
                            'nav title',
                          ),
                        )
                      : const NavBar(
                          title: Text(
                            'nav title',
                          ),
                        ),
                ),
              );
            },
          );
  }
}
