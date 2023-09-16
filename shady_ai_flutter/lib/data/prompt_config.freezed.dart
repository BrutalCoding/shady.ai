// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompt_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PromptConfig {
  String get label => throw _privateConstructorUsedError;
  String get defaultPromptFormat => throw _privateConstructorUsedError;
  String? get system => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  String? get assistant => throw _privateConstructorUsedError;
  int? get contextSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PromptConfigCopyWith<PromptConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromptConfigCopyWith<$Res> {
  factory $PromptConfigCopyWith(
          PromptConfig value, $Res Function(PromptConfig) then) =
      _$PromptConfigCopyWithImpl<$Res, PromptConfig>;
  @useResult
  $Res call(
      {String label,
      String defaultPromptFormat,
      String? system,
      String? user,
      String? assistant,
      int? contextSize});
}

/// @nodoc
class _$PromptConfigCopyWithImpl<$Res, $Val extends PromptConfig>
    implements $PromptConfigCopyWith<$Res> {
  _$PromptConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? defaultPromptFormat = null,
    Object? system = freezed,
    Object? user = freezed,
    Object? assistant = freezed,
    Object? contextSize = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPromptFormat: null == defaultPromptFormat
          ? _value.defaultPromptFormat
          : defaultPromptFormat // ignore: cast_nullable_to_non_nullable
              as String,
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      assistant: freezed == assistant
          ? _value.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as String?,
      contextSize: freezed == contextSize
          ? _value.contextSize
          : contextSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PromptConfigCopyWith<$Res>
    implements $PromptConfigCopyWith<$Res> {
  factory _$$_PromptConfigCopyWith(
          _$_PromptConfig value, $Res Function(_$_PromptConfig) then) =
      __$$_PromptConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      String defaultPromptFormat,
      String? system,
      String? user,
      String? assistant,
      int? contextSize});
}

/// @nodoc
class __$$_PromptConfigCopyWithImpl<$Res>
    extends _$PromptConfigCopyWithImpl<$Res, _$_PromptConfig>
    implements _$$_PromptConfigCopyWith<$Res> {
  __$$_PromptConfigCopyWithImpl(
      _$_PromptConfig _value, $Res Function(_$_PromptConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? defaultPromptFormat = null,
    Object? system = freezed,
    Object? user = freezed,
    Object? assistant = freezed,
    Object? contextSize = freezed,
  }) {
    return _then(_$_PromptConfig(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPromptFormat: null == defaultPromptFormat
          ? _value.defaultPromptFormat
          : defaultPromptFormat // ignore: cast_nullable_to_non_nullable
              as String,
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      assistant: freezed == assistant
          ? _value.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as String?,
      contextSize: freezed == contextSize
          ? _value.contextSize
          : contextSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_PromptConfig implements _PromptConfig {
  const _$_PromptConfig(
      {required this.label,
      required this.defaultPromptFormat,
      this.system,
      this.user,
      this.assistant,
      this.contextSize});

  @override
  final String label;
  @override
  final String defaultPromptFormat;
  @override
  final String? system;
  @override
  final String? user;
  @override
  final String? assistant;
  @override
  final int? contextSize;

  @override
  String toString() {
    return 'PromptConfig(label: $label, defaultPromptFormat: $defaultPromptFormat, system: $system, user: $user, assistant: $assistant, contextSize: $contextSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PromptConfig &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.defaultPromptFormat, defaultPromptFormat) ||
                other.defaultPromptFormat == defaultPromptFormat) &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant) &&
            (identical(other.contextSize, contextSize) ||
                other.contextSize == contextSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, defaultPromptFormat,
      system, user, assistant, contextSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PromptConfigCopyWith<_$_PromptConfig> get copyWith =>
      __$$_PromptConfigCopyWithImpl<_$_PromptConfig>(this, _$identity);
}

abstract class _PromptConfig implements PromptConfig {
  const factory _PromptConfig(
      {required final String label,
      required final String defaultPromptFormat,
      final String? system,
      final String? user,
      final String? assistant,
      final int? contextSize}) = _$_PromptConfig;

  @override
  String get label;
  @override
  String get defaultPromptFormat;
  @override
  String? get system;
  @override
  String? get user;
  @override
  String? get assistant;
  @override
  int? get contextSize;
  @override
  @JsonKey(ignore: true)
  _$$_PromptConfigCopyWith<_$_PromptConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
