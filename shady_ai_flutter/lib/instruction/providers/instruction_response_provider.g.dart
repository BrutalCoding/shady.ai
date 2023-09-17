// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_response_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$instructionResponseHash() =>
    r'8254bdb2f9e9a52f444fbdf2c716da81b0b4dd13';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$InstructionResponse
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String pathToFile;
  late final String promptTemplate;

  FutureOr<String> build({
    required String pathToFile,
    required String promptTemplate,
  });
}

/// See also [InstructionResponse].
@ProviderFor(InstructionResponse)
const instructionResponseProvider = InstructionResponseFamily();

/// See also [InstructionResponse].
class InstructionResponseFamily extends Family<AsyncValue<String>> {
  /// See also [InstructionResponse].
  const InstructionResponseFamily();

  /// See also [InstructionResponse].
  InstructionResponseProvider call({
    required String pathToFile,
    required String promptTemplate,
  }) {
    return InstructionResponseProvider(
      pathToFile: pathToFile,
      promptTemplate: promptTemplate,
    );
  }

  @override
  InstructionResponseProvider getProviderOverride(
    covariant InstructionResponseProvider provider,
  ) {
    return call(
      pathToFile: provider.pathToFile,
      promptTemplate: provider.promptTemplate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'instructionResponseProvider';
}

/// See also [InstructionResponse].
class InstructionResponseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<InstructionResponse, String> {
  /// See also [InstructionResponse].
  InstructionResponseProvider({
    required String pathToFile,
    required String promptTemplate,
  }) : this._internal(
          () => InstructionResponse()
            ..pathToFile = pathToFile
            ..promptTemplate = promptTemplate,
          from: instructionResponseProvider,
          name: r'instructionResponseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$instructionResponseHash,
          dependencies: InstructionResponseFamily._dependencies,
          allTransitiveDependencies:
              InstructionResponseFamily._allTransitiveDependencies,
          pathToFile: pathToFile,
          promptTemplate: promptTemplate,
        );

  InstructionResponseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pathToFile,
    required this.promptTemplate,
  }) : super.internal();

  final String pathToFile;
  final String promptTemplate;

  @override
  FutureOr<String> runNotifierBuild(
    covariant InstructionResponse notifier,
  ) {
    return notifier.build(
      pathToFile: pathToFile,
      promptTemplate: promptTemplate,
    );
  }

  @override
  Override overrideWith(InstructionResponse Function() create) {
    return ProviderOverride(
      origin: this,
      override: InstructionResponseProvider._internal(
        () => create()
          ..pathToFile = pathToFile
          ..promptTemplate = promptTemplate,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pathToFile: pathToFile,
        promptTemplate: promptTemplate,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<InstructionResponse, String>
      createElement() {
    return _InstructionResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InstructionResponseProvider &&
        other.pathToFile == pathToFile &&
        other.promptTemplate == promptTemplate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pathToFile.hashCode);
    hash = _SystemHash.combine(hash, promptTemplate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InstructionResponseRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `pathToFile` of this provider.
  String get pathToFile;

  /// The parameter `promptTemplate` of this provider.
  String get promptTemplate;
}

class _InstructionResponseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<InstructionResponse, String>
    with InstructionResponseRef {
  _InstructionResponseProviderElement(super.provider);

  @override
  String get pathToFile => (origin as InstructionResponseProvider).pathToFile;
  @override
  String get promptTemplate =>
      (origin as InstructionResponseProvider).promptTemplate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
