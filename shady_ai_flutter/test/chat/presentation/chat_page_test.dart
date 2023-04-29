// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shady_ai/chat/presentation/chat_page.dart';

void main() {
  group('ChatPage', () {
    testWidgets('renders ChatPage', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ChatPage(),
          ),
        ),
      );
      expect(find.byKey(const Key('chat_page_scaffold')), findsOneWidget);
    });
  });
}
