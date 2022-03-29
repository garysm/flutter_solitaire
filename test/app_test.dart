import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/app.dart';

void main() {
  testWidgets(
    'Counter increments smoke test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: SolitaireApp(),
        ),
      );
    },
  );
}
