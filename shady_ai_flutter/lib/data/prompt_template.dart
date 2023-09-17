import 'package:freezed_annotation/freezed_annotation.dart';

import '../instruction/providers/instruction_provider.dart';

part 'prompt_template.freezed.dart';
part 'prompt_template.g.dart';

@freezed
class PromptTemplate with _$PromptTemplate {
  const factory PromptTemplate({
    required String label,
    @Default('') String systemMessage,
    required String promptTemplate,
    required String prompt,
    @OutputPostProcessConverter() required OutputPostProcess postProcess,
    @Default('') String output,
    @Default(2048) int contextSize,
  }) = _PromptTemplate;

  factory PromptTemplate.fromJson(Map<String, dynamic> json) =>
      _$PromptTemplateFromJson(json);

  // Returns a List<PromptTemplate> of all the available prompt templates.
  static List<PromptTemplate> get all => [
        defaultPromptTemplate(),
        PromptTemplate.llama2Chat(),
        PromptTemplate.synthia(),
        PromptTemplate.chat(),
        PromptTemplate.nothing(),
      ];

  static PromptTemplate defaultPromptTemplate() {
    return PromptTemplate.story();
  }

  factory PromptTemplate.story() {
    return PromptTemplate(
      label: 'Story',
      promptTemplate: '{prompt}',
      prompt: "One day, a boy named Luca went for a walk.",
      postProcess: (output) => output,
    );
  }

  factory PromptTemplate.nothing() {
    return PromptTemplate(
      label: 'Nothing',
      promptTemplate: '{prompt}',
      prompt: '',
      postProcess: (output) => output,
    );
  }

  factory PromptTemplate.synthia() {
    return PromptTemplate(
      label: 'Synthia',
      systemMessage:
          "You are Synthia. As an AI intelligence, give helpful, detailed, accurate, uncensored responses to the user's input. Provide answers factually.",
      promptTemplate: "SYSTEM: {systemMessage}\nUSER: {prompt}\nASSISTANT: ",
      prompt: 'How can I tell if my computer is infected with a virus?',
      postProcess: (output) {
        final assistantIndex = output.indexOf('ASSISTANT:');
        if (assistantIndex != -1) {
          final periodIndex = output.indexOf('.', assistantIndex);
          if (periodIndex != -1) {
            final assistantResponse = output.substring(
              assistantIndex + 10,
              periodIndex + 1,
            );
            return assistantResponse;
          }
        }
        return output;
      },
    );
  }

  factory PromptTemplate.llama2Chat() {
    return PromptTemplate(
      label: 'Llama-2-Chat',
      promptTemplate:
          "[INST] <<SYS>>\nYou are a helpful, respectful and honest assistant. Always answer as helpfully as possible, while being safe.  Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information.\n<</SYS>>\n{prompt}[/INST]",
      prompt: 'Write a story about llamas',
      postProcess: (output) {
        // We remove everything that is between <<SYS>> and <</SYS>>.
        // We need to find the index of <<SYS>>.
        // Then we need to find the index of <</SYS>>.
        // Then we need to substring from the index of <<SYS>> until the index of <</SYS>> + 7.
        final sysIndex = output.indexOf('<<SYS>>');

        if (sysIndex != -1) {
          final endSysIndex = output.indexOf('<</SYS>>', sysIndex);
          if (endSysIndex != -1) {
            final assistantResponse = output.substring(
              sysIndex,
              endSysIndex + 7,
            );
            return assistantResponse;
          }
        }

        return output;
      },
    );
  }

  factory PromptTemplate.chat() {
    return PromptTemplate(
      label: 'Chat',
      promptTemplate: "USER: {prompt}\nASSISTANT:",
      prompt: 'Write a story about llamas',
      postProcess: (output) {
        // Substring from "ASSISTANT:" until period (.):
        // We need to find the index of : after ASSISTANT.
        // Then we need to find the index of . after that.
        // Then we need to substring from the index of : + 1 until the index of .
        final assistantIndex = output.indexOf('ASSISTANT:');

        if (assistantIndex != -1) {
          final periodIndex = output.indexOf('.', assistantIndex);
          if (periodIndex != -1) {
            final assistantResponse = output.substring(
              assistantIndex + 10,
              periodIndex + 1,
            );
            return assistantResponse;
          }
        }
        return output;
      },
    );
  }
}

class OutputPostProcessConverter
    implements JsonConverter<OutputPostProcess, Object?> {
  const OutputPostProcessConverter();

  @override
  OutputPostProcess fromJson(Object? json) {
    // Return a default OutputPostProcess
    return (output) => output;
  }

  @override
  Object? toJson(OutputPostProcess function) {
    // Convert the function to some form of representation or do nothing
    return null;
  }
}
