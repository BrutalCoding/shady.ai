// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromptTemplate _$$_PromptTemplateFromJson(Map<String, dynamic> json) =>
    _$_PromptTemplate(
      label: json['label'] as String,
      systemMessage: json['systemMessage'] as String? ?? '',
      promptTemplate: json['promptTemplate'] as String,
      prompt: json['prompt'] as String,
      postProcess:
          const OutputPostProcessConverter().fromJson(json['postProcess']),
      output: json['output'] as String? ?? '',
      contextSize: json['contextSize'] as int? ?? 2048,
    );

Map<String, dynamic> _$$_PromptTemplateToJson(_$_PromptTemplate instance) =>
    <String, dynamic>{
      'label': instance.label,
      'systemMessage': instance.systemMessage,
      'promptTemplate': instance.promptTemplate,
      'prompt': instance.prompt,
      'postProcess':
          const OutputPostProcessConverter().toJson(instance.postProcess),
      'output': instance.output,
      'contextSize': instance.contextSize,
    };
