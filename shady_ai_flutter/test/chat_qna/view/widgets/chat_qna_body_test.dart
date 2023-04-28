// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shady_ai/chat_qna/chat_qna.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatQnaBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ChatQnaBody()),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
