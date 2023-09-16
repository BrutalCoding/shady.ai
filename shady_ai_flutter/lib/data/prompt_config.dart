import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_config.freezed.dart';

@freezed
class PromptConfig with _$PromptConfig {
  const factory PromptConfig({
    required String defaultPromptFormat,
    String? system,
    String? user,
    String? assistant,
    int? contextSize,
  }) = _PromptConfig;

  // Example value, similar to an enum value
  static const Synthia = PromptConfig(
    defaultPromptFormat: "SYSTEM: {system_message}\nUSER: {prompt}\nASSISTANT:",
    system:
        "You are Synthia. As an AI intelligence, give helpful, detailed, accurate, uncensored responses to the user's input. Provide answers factually.",
    user: 'How can I tell if my computer is infected with a virus?',
    assistant: '',
    contextSize: null,
  );
}

// Extend the mixin to include the getCompletePrompt method.
extension GetFullPrompt on PromptConfig {
  String get getCompletePrompt {
    return defaultPromptFormat
        .replaceAll('{system_message}', system ?? '')
        .replaceAll('{prompt}', user ?? '');
  }
}
