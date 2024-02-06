import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('flat banner test', () {
    group('light mode', () {
      testWidgets('informational', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: const Material(
                  color: Colors.white,
                  child: FlatBanner(
                    child: Text('flat banner'),
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final flatBannerFinder = find.byType(FlatBanner);
        await expectLater(
          flatBannerFinder,
          matchesGoldenFile('goldens/flat_banner/light_mode/informational.png'),
        );

        final materialFinder = find.byType(Material);

        final flatBannerMaterialFinder =
            find.descendant(of: flatBannerFinder, matching: materialFinder);
        final flatBannerMaterialWidget =
            tester.widget<Material>(flatBannerMaterialFinder);
        expect(flatBannerMaterialWidget.color, const Color(0xfff5f5f5));
        final textFinder = find.byType(RichText);
        final flatBannerTextFinder = find.descendant(
          of: flatBannerFinder,
          matching: textFinder,
        );
        expect(flatBannerTextFinder, findsOneWidget);
        final flatBannerTextWidget =
            tester.widget<RichText>(flatBannerTextFinder);
        expect(flatBannerTextWidget.text.toPlainText(), 'flat banner');
        expect(flatBannerTextWidget.text.style!.color, const Color(0xff000000));
        expect(flatBannerTextWidget.text.style!.fontFamily, 'SFPro');
      });

      testWidgets('warning', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.white,
                  child: FlatBanner(
                    mode: BannerMode.error,
                    action: BannerAction(
                      child: const Text('actions'),
                      onPressed: () {},
                    ),
                    child: const Text('flat banner'),
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final flatBannerFinder = find.byType(FlatBanner);
        await expectLater(
          flatBannerFinder,
          matchesGoldenFile('goldens/flat_banner/light_mode/warning.png'),
        );

        final materialFinder = find.descendant(
          of: flatBannerFinder,
          matching: find.byType(Material),
        );

        final bannerMaterialFinder = materialFinder.first;

        final bannerMaterialWidget =
            tester.widget<Material>(bannerMaterialFinder);
        expect(bannerMaterialWidget.color, const Color(0x29a80700));
        final textFinder = find.byType(RichText);
        final flatBannerTextFinder = find
            .descendant(
              of: materialFinder.first,
              matching: textFinder,
            )
            .first;
        expect(flatBannerTextFinder, findsOneWidget);
        final flatBannerTextWidget =
            tester.widget<RichText>(flatBannerTextFinder);
        expect(flatBannerTextWidget.text.toPlainText(), 'flat banner');
        expect(flatBannerTextWidget.text.style!.color, const Color(0xff000000));
        expect(flatBannerTextWidget.text.style!.fontFamily, 'SFPro');
        final actionTextFinder =
            find.descendant(of: materialFinder.last, matching: textFinder);
        expect(actionTextFinder, findsOneWidget);
        final actionTextWidget = tester.widget<RichText>(actionTextFinder);
        expect(actionTextWidget.text.toPlainText(), 'actions');
        expect(actionTextWidget.text.style!.color, const Color(0xffa80700));
        expect(actionTextWidget.text.style!.fontFamily, 'SFPro');
      });
    });
    group('dark mode', () {
      testWidgets('informational', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: const Material(
                  color: Colors.black,
                  child: FlatBanner(
                    child: Text('flat banner'),
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final flatBannerFinder = find.byType(FlatBanner);
        await expectLater(
          flatBannerFinder,
          matchesGoldenFile('goldens/flat_banner/dark_mode/informational.png'),
        );
        final materialFinder = find.byType(Material);

        final flatBannerMaterialFinder =
            find.descendant(of: flatBannerFinder, matching: materialFinder);
        final flatBannerMaterialWidget =
            tester.widget<Material>(flatBannerMaterialFinder);
        expect(flatBannerMaterialWidget.color, const Color(0xff3d3d3d));
        final textFinder = find.byType(RichText);
        final flatBannerTextFinder = find.descendant(
          of: flatBannerFinder,
          matching: textFinder,
        );
        expect(flatBannerTextFinder, findsOneWidget);
        final flatBannerTextWidget =
            tester.widget<RichText>(flatBannerTextFinder);
        expect(flatBannerTextWidget.text.toPlainText(), 'flat banner');
        expect(flatBannerTextWidget.text.style!.color, const Color(0xffedefe0));
        expect(flatBannerTextWidget.text.style!.fontFamily, 'SFPro');
      });
      testWidgets('warning', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.black,
                  child: FlatBanner(
                    mode: BannerMode.error,
                    action: BannerAction(
                      child: const Text('actions'),
                      onPressed: () {},
                    ),
                    child: const Text('flat banner'),
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final flatBannerFinder = find.byType(FlatBanner);
        await expectLater(
          flatBannerFinder,
          matchesGoldenFile('goldens/flat_banner/dark_mode/warning.png'),
        );

        final materialFinder = find.descendant(
          of: flatBannerFinder,
          matching: find.byType(Material),
        );

        final bannerMaterialFinder = materialFinder.first;

        final bannerMaterialWidget =
            tester.widget<Material>(bannerMaterialFinder);
        expect(bannerMaterialWidget.color, const Color(0xff5f2c29));
        final textFinder = find.byType(RichText);
        final flatBannerTextFinder = find
            .descendant(
              of: materialFinder.first,
              matching: textFinder,
            )
            .first;
        expect(flatBannerTextFinder, findsOneWidget);
        final flatBannerTextWidget =
            tester.widget<RichText>(flatBannerTextFinder);
        expect(flatBannerTextWidget.text.toPlainText(), 'flat banner');
        expect(flatBannerTextWidget.text.style!.color, const Color(0xffedefe0));
        expect(flatBannerTextWidget.text.style!.fontFamily, 'SFPro');
        final actionTextFinder =
            find.descendant(of: materialFinder.last, matching: textFinder);
        expect(actionTextFinder, findsOneWidget);
        final actionTextWidget = tester.widget<RichText>(actionTextFinder);
        expect(actionTextWidget.text.toPlainText(), 'actions');
        expect(actionTextWidget.text.style!.color, const Color(0xffff8f87));
        expect(actionTextWidget.text.style!.fontFamily, 'SFPro');
      });
    });
  });
}
