import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('When value is true then the tick box Tile is checked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TickBoxTileTest(
        value: true,
        isDisabled: false,
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();
    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile(
        Uri.file('goldens/tick_box_tile.checked.png'),
      ),
    );
  });

  testWidgets('When value is false then the tick box tile is unchecked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TickBoxTileTest(
        value: false,
        isDisabled: false,
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();
    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile(
        Uri.file('goldens/tick_box_tile.unchecked.png'),
      ),
    );
  });
  testWidgets('check box test, empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TickBoxTileTest(
        value: false,
        isDisabled: false,
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.unchecked.png'),
    );

    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );
  });

  testWidgets('check box test, filled', (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TickBoxTileTest(
        value: true,
        isDisabled: false,
        color: Colors.black,
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.checked.png'),
    );

    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );
  });

  testWidgets(
      'the tick box tile is unchecked, user taps on it to mark it checked',
      (WidgetTester tester) async {
    final checkedNotifier = ValueNotifier(false);
    await tester.pumpWidget(
      ValueListenableBuilder<bool>(
        valueListenable: checkedNotifier,
        builder: (context, value, _) {
          return _TickBoxTileTest(
            value: value,
            isDisabled: false,
            onPressed: () {
              checkedNotifier.value = !value;
            },
            color: Colors.black,
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.unchecked.png'),
    );
    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );

    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();

    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.checked.png'),
    );
  });

  testWidgets(
      'the tick box tile is checked, user taps on it to mark it unchecked',
      (WidgetTester tester) async {
    final checkedNotifier = ValueNotifier(true);
    await tester.pumpWidget(
      ValueListenableBuilder<bool>(
        valueListenable: checkedNotifier,
        builder: (context, value, _) {
          return _TickBoxTileTest(
            value: value,
            isDisabled: false,
            onPressed: () {
              checkedNotifier.value = !value;
            },
            color: Colors.black,
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.checked.png'),
    );
    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );

    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();

    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.unchecked.png'),
    );
  });

  testWidgets(
      'the tick box tile is checked with disable property, user taps on it and there is no change',
      (WidgetTester tester) async {
    final checkedNotifier = ValueNotifier(true);
    await tester.pumpWidget(
      ValueListenableBuilder<bool>(
        valueListenable: checkedNotifier,
        builder: (context, value, _) {
          return _TickBoxTileTest(
            value: value,
            isDisabled: true,
            onPressed: () {
              checkedNotifier.value = !value;
            },
            color: Colors.black,
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.checked.png'),
    );
    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );

    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();

    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.checked.png'),
    );
  });
  testWidgets(
      'the tick box tile is unchecked with disable property, user taps on it and there is no change',
      (WidgetTester tester) async {
    final checkedNotifier = ValueNotifier(false);
    await tester.pumpWidget(
      ValueListenableBuilder<bool>(
        valueListenable: checkedNotifier,
        builder: (context, value, _) {
          return _TickBoxTileTest(
            value: value,
            isDisabled: true,
            onPressed: () {
              checkedNotifier.value = !value;
            },
            color: Colors.black,
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    final tickBoxTileFinder = find.byType(TickBoxTile);
    expect(tickBoxTileFinder, findsOneWidget);
    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.unchecked.png'),
    );
    final inkWellFinder = find.byType(InkWell);

    final textFinder = find.byType(Text);
    final checkBoxTextFinder = find.descendant(
      of: inkWellFinder,
      matching: textFinder,
    );
    expect(checkBoxTextFinder, findsOneWidget);

    final checkBoxTextWidget = tester.widget<Text>(checkBoxTextFinder);

    expect(checkBoxTextWidget.data, 'yes');

    final textStyle = checkBoxTextWidget.style;
    expect(
      textStyle?.color,
      Colors.black,
    );

    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();

    await expectLater(
      tickBoxTileFinder,
      matchesGoldenFile('goldens/tick_box_tile.unchecked.png'),
    );
  });
}

class _TickBoxTileTest extends StatelessWidget {
  const _TickBoxTileTest({
    required this.value,
    required this.isDisabled,
    this.color,
    this.onPressed,
  });

  final bool value;
  final bool isDisabled;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      brightness: Brightness.light,
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.themeData,
          home: Material(
            color: Colors.white,
            child: TickBoxTile(
              onPressed: onPressed,
              isDisabled: isDisabled,
              value: value,
              label: Text(
                'yes',
                style: TextStyle(color: color),
              ),
            ),
          ),
        );
      },
    );
  }
}
