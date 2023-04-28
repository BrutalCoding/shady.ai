import 'package:flutter/material.dart';
import 'package:shady_ai/chat_qna/widgets/chat_qna_body.dart';

/// {@template chat_qna_page}
/// A page that can be used to chat with the AI.
/// {@endtemplate}
class ChatQnaPage extends StatelessWidget {
  /// {@macro chat_qna_page}
  const ChatQnaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatQnaView(),
    );
  }
}

/// {@template chat_qna_view}
/// Displays the Body of ChatQnaView
/// {@endtemplate}
class ChatQnaView extends StatelessWidget {
  /// {@macro chat_qna_view}
  const ChatQnaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatQnaBody();
  }
}
