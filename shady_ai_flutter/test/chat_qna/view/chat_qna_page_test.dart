// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shady_ai/chat_qna/chat_qna.dart';

void main() {
  group('ChatQnaPage', () {
    testWidgets('renders ChatQnaView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatQnaPage()));
      expect(find.byType(ChatQnaView), findsOneWidget);
    });
  });
}
