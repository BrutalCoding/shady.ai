import 'package:riverpod/riverpod.dart';

final chatQnaProvider = StateNotifierProvider.autoDispose((ref) {
  return ChatQnaProvider();
});

class ChatQnaProvider extends StateNotifier<int> {
  ChatQnaProvider() : super(0);

  void increment() => state++;
  void decrement() => state--;
}
