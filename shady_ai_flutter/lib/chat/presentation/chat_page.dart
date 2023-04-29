import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/chat_provider.dart';

/// {@template chat_page}
/// A page that can be used to chat with AI.
/// {@endtemplate}
class ChatPage extends StatelessWidget {
  /// {@macro chat_page}
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: Key('chat_page_scaffold'),
      body: ChatPageBody(),
    );
  }
}

class ChatPageBody extends HookConsumerWidget {
  const ChatPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(chatProvider);
    return Text(
      count.toString(),
    );
  }
}
