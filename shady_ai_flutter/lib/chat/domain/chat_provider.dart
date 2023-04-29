import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatProvider = StateNotifierProvider.autoDispose((ref) {
  return ChatProvider();
});

class ChatProvider extends StateNotifier<int> {
  ChatProvider() : super(0);
}
