import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('nav bar action test', () {
    group('light mode', () {
      testWidgets('nav bar action test, back', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: const Material(
                  color: Colors.white,
                  child: NavBarAction.back(),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final backIconFinder = find.byType(IconButton);
        expect(backIconFinder, findsOneWidget);
        await expectLater(
          backIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/light_mode/nav_bar_back.png',
          ),
        );
      });
      testWidgets('nav bar action test, text', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.white,
                  child: NavBarAction.text(label: 'text', onPressed: () {}),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final textFinder = find.text('text');
        expect(textFinder, findsOneWidget);
        await expectLater(
          textFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/light_mode/nav_bar_text.png',
          ),
        );
      });
      testWidgets('nav bar action test, chevron down icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.white,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.chevronDown,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final chevronDownIconFinder = find.byType(IconButton);
        expect(chevronDownIconFinder, findsOneWidget);
        await expectLater(
          chevronDownIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/light_mode/nav_bar_icon_chevron_down.png',
          ),
        );
      });
      testWidgets('nav bar action test, chevron left icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.white,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.chevronLeft,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final chevronLeftIcon = find.byType(IconButton);
        expect(chevronLeftIcon, findsOneWidget);
        await expectLater(
          chevronLeftIcon,
          matchesGoldenFile(
            'goldens/nav_bar_action/light_mode/nav_bar_icon_chevron_left.png',
          ),
        );
      });
      testWidgets('nav bar action test, close icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.light,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.white,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.close,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final closeIconFinder = find.byType(IconButton);
        expect(closeIconFinder, findsOneWidget);
        await expectLater(
          closeIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/light_mode/nav_bar_icon_close.png',
          ),
        );
      });
    });
    group('dark mode', () {
      testWidgets('nav bar action test, back', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: const Material(
                  color: Colors.black,
                  child: NavBarAction.back(),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final backIconFinder = find.byType(IconButton);
        expect(backIconFinder, findsOneWidget);
        await expectLater(
          backIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/dark_mode/nav_bar_back.png',
          ),
        );
      });
      testWidgets('nav bar action test, text', (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.black,
                  child: NavBarAction.text(label: 'text', onPressed: () {}),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final textFinder = find.text('text');
        expect(textFinder, findsOneWidget);
        await expectLater(
          textFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/dark_mode/nav_bar_text.png',
          ),
        );
      });
      testWidgets('nav bar action test, chevron down icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.black,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.chevronDown,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final chevronDownIconFinder = find.byType(IconButton);
        expect(chevronDownIconFinder, findsOneWidget);
        await expectLater(
          chevronDownIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/dark_mode/nav_bar_icon_chevron_down.png',
          ),
        );
      });
      testWidgets('nav bar action test, chevron left icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.black,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.chevronLeft,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final chevronLeftIcon = find.byType(IconButton);
        expect(chevronLeftIcon, findsOneWidget);
        await expectLater(
          chevronLeftIcon,
          matchesGoldenFile(
            'goldens/nav_bar_action/dark_mode/nav_bar_icon_chevron_left.png',
          ),
        );
      });
      testWidgets('nav bar action test, close icon',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          AppTheme(
            brightness: Brightness.dark,
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: context.themeData,
                home: Material(
                  color: Colors.black,
                  child: NavBarAction.icon(
                    icon: NavBarIcons.close,
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        final closeIconFinder = find.byType(IconButton);
        expect(closeIconFinder, findsOneWidget);
        await expectLater(
          closeIconFinder,
          matchesGoldenFile(
            'goldens/nav_bar_action/dark_mode/nav_bar_icon_close.png',
          ),
        );
      });
    });
  });
}
