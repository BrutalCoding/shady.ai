import 'package:flutter/material.dart';
import 'package:shady_ai/chat_qna/provider/provider.dart';

/// {@template chat_qna_body}
/// Body of the ChatQnaPage.
///
/// AI that answers questions.
/// {@endtemplate}
class ChatQnaBody extends ConsumerWidget {
  /// {@macro chat_qna_body}
  const ChatQnaBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(chatQnaProvider);

    return Text(count.toString());
  }
}
