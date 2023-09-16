// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instructionHash() => r'dd38b4ddd2f016fbdfb1443f2caecb2673843c38';

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
