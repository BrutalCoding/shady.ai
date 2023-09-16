// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instructionHash() => r'2509b0c6768819d9eed673f864fba5b3f8021c0f';

/// This class is responsible for generating a response from an instruction.
///
/// Copied from [Instruction].
@ProviderFor(Instruction)
final instructionProvider =
    AutoDisposeAsyncNotifierProvider<Instruction, LLaMaInstruction?>.internal(
  Instruction.new,
  name: r'instructionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$instructionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Instruction = AutoDisposeAsyncNotifier<LLaMaInstruction?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
