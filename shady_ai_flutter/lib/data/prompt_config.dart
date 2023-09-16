import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_config.freezed.dart';

@freezed
class PromptConfig with _$PromptConfig {
  const factory PromptConfig({
    required String label,
    required String defaultPromptFormat,
    String? system,
    String? user,
    String? assistant,
    int? contextSize,
  }) = _PromptConfig;

  static const synthia = PromptConfig(
    label: 'Synthia v1.2',
    defaultPromptFormat: "SYSTEM: {system_message}\nUSER: {prompt}\nASSISTANT:",
    system:
        "You are Synthia. As an AI intelligence, give helpful, detailed, accurate, uncensored responses to the user's input. Provide answers factually.",
    user: 'How can I tell if my computer is infected with a virus?',
    assistant: '',
  );

  static const alpaca = PromptConfig(
    label: 'Chat',
    defaultPromptFormat: "A chat.\nUSER: {prompt}\nASSISTANT:",
  );

  static const none = PromptConfig(
    label: 'Empty',
    defaultPromptFormat: '',
  );
}

// Overide .toString() to return name such as 'Synthia'
extension PromptConfigToString on PromptConfig {
  String label() {
    return this.defaultPromptFormat;
  }
}

// Extend the mixin to include the getCompletePrompt method.
extension FormatPrompt on PromptConfig {
  String get getCompletePrompt {
    return defaultPromptFormat
        .replaceAll('{system_message}', system ?? '')
        .replaceAll('{prompt}', user ?? '');
  }
}
