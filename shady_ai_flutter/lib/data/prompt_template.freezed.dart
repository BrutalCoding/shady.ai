// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompt_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PromptTemplate _$PromptTemplateFromJson(Map<String, dynamic> json) {
  return _PromptTemplate.fromJson(json);
}

/// @nodoc
mixin _$PromptTemplate {
  String get label => throw _privateConstructorUsedError;
  String get systemMessage => throw _privateConstructorUsedError;
  String get promptTemplate => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  @OutputPostProcessConverter()
  OutputPostProcess get postProcess => throw _privateConstructorUsedError;
  String get output => throw _privateConstructorUsedError;
  int get contextSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromptTemplateCopyWith<PromptTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromptTemplateCopyWith<$Res> {
  factory $PromptTemplateCopyWith(
          PromptTemplate value, $Res Function(PromptTemplate) then) =
      _$PromptTemplateCopyWithImpl<$Res, PromptTemplate>;
  @useResult
  $Res call(
      {String label,
      String systemMessage,
      String promptTemplate,
      String prompt,
      @OutputPostProcessConverter() OutputPostProcess postProcess,
      String output,
      int contextSize});
}

/// @nodoc
class _$PromptTemplateCopyWithImpl<$Res, $Val extends PromptTemplate>
    implements $PromptTemplateCopyWith<$Res> {
  _$PromptTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? systemMessage = null,
    Object? promptTemplate = null,
    Object? prompt = null,
    Object? postProcess = null,
    Object? output = null,
    Object? contextSize = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      systemMessage: null == systemMessage
          ? _value.systemMessage
          : systemMessage // ignore: cast_nullable_to_non_nullable
              as String,
      promptTemplate: null == promptTemplate
          ? _value.promptTemplate
          : promptTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      postProcess: null == postProcess
          ? _value.postProcess
          : postProcess // ignore: cast_nullable_to_non_nullable
              as OutputPostProcess,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      contextSize: null == contextSize
          ? _value.contextSize
          : contextSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PromptTemplateCopyWith<$Res>
    implements $PromptTemplateCopyWith<$Res> {
  factory _$$_PromptTemplateCopyWith(
          _$_PromptTemplate value, $Res Function(_$_PromptTemplate) then) =
      __$$_PromptTemplateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      String systemMessage,
      String promptTemplate,
      String prompt,
      @OutputPostProcessConverter() OutputPostProcess postProcess,
      String output,
      int contextSize});
}

/// @nodoc
class __$$_PromptTemplateCopyWithImpl<$Res>
    extends _$PromptTemplateCopyWithImpl<$Res, _$_PromptTemplate>
    implements _$$_PromptTemplateCopyWith<$Res> {
  __$$_PromptTemplateCopyWithImpl(
      _$_PromptTemplate _value, $Res Function(_$_PromptTemplate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? systemMessage = null,
    Object? promptTemplate = null,
    Object? prompt = null,
    Object? postProcess = null,
    Object? output = null,
    Object? contextSize = null,
  }) {
    return _then(_$_PromptTemplate(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      systemMessage: null == systemMessage
          ? _value.systemMessage
          : systemMessage // ignore: cast_nullable_to_non_nullable
              as String,
      promptTemplate: null == promptTemplate
          ? _value.promptTemplate
          : promptTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      postProcess: null == postProcess
          ? _value.postProcess
          : postProcess // ignore: cast_nullable_to_non_nullable
              as OutputPostProcess,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      contextSize: null == contextSize
          ? _value.contextSize
          : contextSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PromptTemplate implements _PromptTemplate {
  const _$_PromptTemplate(
      {required this.label,
      this.systemMessage = '',
      required this.promptTemplate,
      required this.prompt,
      @OutputPostProcessConverter() required this.postProcess,
      this.output = '',
      this.contextSize = 2048});

  factory _$_PromptTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_PromptTemplateFromJson(json);

  @override
  final String label;
  @override
  @JsonKey()
  final String systemMessage;
  @override
  final String promptTemplate;
  @override
  final String prompt;
  @override
  @OutputPostProcessConverter()
  final OutputPostProcess postProcess;
  @override
  @JsonKey()
  final String output;
  @override
  @JsonKey()
  final int contextSize;

  @override
  String toString() {
    return 'PromptTemplate(label: $label, systemMessage: $systemMessage, promptTemplate: $promptTemplate, prompt: $prompt, postProcess: $postProcess, output: $output, contextSize: $contextSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PromptTemplate &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.systemMessage, systemMessage) ||
                other.systemMessage == systemMessage) &&
            (identical(other.promptTemplate, promptTemplate) ||
                other.promptTemplate == promptTemplate) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.postProcess, postProcess) ||
                other.postProcess == postProcess) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.contextSize, contextSize) ||
                other.contextSize == contextSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, systemMessage,
      promptTemplate, prompt, postProcess, output, contextSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PromptTemplateCopyWith<_$_PromptTemplate> get copyWith =>
      __$$_PromptTemplateCopyWithImpl<_$_PromptTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PromptTemplateToJson(
      this,
    );
  }
}

abstract class _PromptTemplate implements PromptTemplate {
  const factory _PromptTemplate(
      {required final String label,
      final String systemMessage,
      required final String promptTemplate,
      required final String prompt,
      @OutputPostProcessConverter()
      required final OutputPostProcess postProcess,
      final String output,
      final int contextSize}) = _$_PromptTemplate;

  factory _PromptTemplate.fromJson(Map<String, dynamic> json) =
      _$_PromptTemplate.fromJson;

  @override
  String get label;
  @override
  String get systemMessage;
  @override
  String get promptTemplate;
  @override
  String get prompt;
  @override
  @OutputPostProcessConverter()
  OutputPostProcess get postProcess;
  @override
  String get output;
  @override
  int get contextSize;
  @override
  @JsonKey(ignore: true)
  _$$_PromptTemplateCopyWith<_$_PromptTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}
