// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_ai_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAiHash() => r'7fa30b43f4b5e46803152c361b4669ecb1962ac4';

/// See also [firebaseAi].
@ProviderFor(firebaseAi)
final firebaseAiProvider = AutoDisposeProvider<FirebaseAI>.internal(
  firebaseAi,
  name: r'firebaseAiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseAiRef = AutoDisposeProviderRef<FirebaseAI>;
String _$geminiModelRepoHash() => r'62a4a09d37a499dbd6072e2044983be8fe5be8a5';

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

/// See also [geminiModelRepo].
@ProviderFor(geminiModelRepo)
const geminiModelRepoProvider = GeminiModelRepoFamily();

/// See also [geminiModelRepo].
class GeminiModelRepoFamily extends Family<GeminiModelRepo> {
  /// See also [geminiModelRepo].
  const GeminiModelRepoFamily();

  /// See also [geminiModelRepo].
  GeminiModelRepoProvider call({String? instruction}) {
    return GeminiModelRepoProvider(instruction: instruction);
  }

  @override
  GeminiModelRepoProvider getProviderOverride(
    covariant GeminiModelRepoProvider provider,
  ) {
    return call(instruction: provider.instruction);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'geminiModelRepoProvider';
}

/// See also [geminiModelRepo].
class GeminiModelRepoProvider extends AutoDisposeProvider<GeminiModelRepo> {
  /// See also [geminiModelRepo].
  GeminiModelRepoProvider({String? instruction})
    : this._internal(
        (ref) => geminiModelRepo(
          ref as GeminiModelRepoRef,
          instruction: instruction,
        ),
        from: geminiModelRepoProvider,
        name: r'geminiModelRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$geminiModelRepoHash,
        dependencies: GeminiModelRepoFamily._dependencies,
        allTransitiveDependencies:
            GeminiModelRepoFamily._allTransitiveDependencies,
        instruction: instruction,
      );

  GeminiModelRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.instruction,
  }) : super.internal();

  final String? instruction;

  @override
  Override overrideWith(
    GeminiModelRepo Function(GeminiModelRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GeminiModelRepoProvider._internal(
        (ref) => create(ref as GeminiModelRepoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        instruction: instruction,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GeminiModelRepo> createElement() {
    return _GeminiModelRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeminiModelRepoProvider && other.instruction == instruction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, instruction.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeminiModelRepoRef on AutoDisposeProviderRef<GeminiModelRepo> {
  /// The parameter `instruction` of this provider.
  String? get instruction;
}

class _GeminiModelRepoProviderElement
    extends AutoDisposeProviderElement<GeminiModelRepo>
    with GeminiModelRepoRef {
  _GeminiModelRepoProviderElement(super.provider);

  @override
  String? get instruction => (origin as GeminiModelRepoProvider).instruction;
}

String _$geminiChatSessionHash() => r'85e7277db60af0292e96f93e814f99ea2cb81827';

/// See also [geminiChatSession].
@ProviderFor(geminiChatSession)
final geminiChatSessionProvider = AutoDisposeProvider<ChatSessionRepo>.internal(
  geminiChatSession,
  name: r'geminiChatSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiChatSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GeminiChatSessionRef = AutoDisposeProviderRef<ChatSessionRepo>;
String _$geminiFunctionCallSessionHash() =>
    r'8a1be485870d3304c922aee5ab3a073d06641708';

/// See also [geminiFunctionCallSession].
@ProviderFor(geminiFunctionCallSession)
const geminiFunctionCallSessionProvider = GeminiFunctionCallSessionFamily();

/// See also [geminiFunctionCallSession].
class GeminiFunctionCallSessionFamily extends Family<ChatSessionRepo> {
  /// See also [geminiFunctionCallSession].
  const GeminiFunctionCallSessionFamily();

  /// See also [geminiFunctionCallSession].
  GeminiFunctionCallSessionProvider call(
    List<Tool> tools, {
    String? instruction,
  }) {
    return GeminiFunctionCallSessionProvider(tools, instruction: instruction);
  }

  @override
  GeminiFunctionCallSessionProvider getProviderOverride(
    covariant GeminiFunctionCallSessionProvider provider,
  ) {
    return call(provider.tools, instruction: provider.instruction);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'geminiFunctionCallSessionProvider';
}

/// See also [geminiFunctionCallSession].
class GeminiFunctionCallSessionProvider
    extends AutoDisposeProvider<ChatSessionRepo> {
  /// See also [geminiFunctionCallSession].
  GeminiFunctionCallSessionProvider(List<Tool> tools, {String? instruction})
    : this._internal(
        (ref) => geminiFunctionCallSession(
          ref as GeminiFunctionCallSessionRef,
          tools,
          instruction: instruction,
        ),
        from: geminiFunctionCallSessionProvider,
        name: r'geminiFunctionCallSessionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$geminiFunctionCallSessionHash,
        dependencies: GeminiFunctionCallSessionFamily._dependencies,
        allTransitiveDependencies:
            GeminiFunctionCallSessionFamily._allTransitiveDependencies,
        tools: tools,
        instruction: instruction,
      );

  GeminiFunctionCallSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tools,
    required this.instruction,
  }) : super.internal();

  final List<Tool> tools;
  final String? instruction;

  @override
  Override overrideWith(
    ChatSessionRepo Function(GeminiFunctionCallSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GeminiFunctionCallSessionProvider._internal(
        (ref) => create(ref as GeminiFunctionCallSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tools: tools,
        instruction: instruction,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ChatSessionRepo> createElement() {
    return _GeminiFunctionCallSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeminiFunctionCallSessionProvider &&
        other.tools == tools &&
        other.instruction == instruction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tools.hashCode);
    hash = _SystemHash.combine(hash, instruction.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeminiFunctionCallSessionRef on AutoDisposeProviderRef<ChatSessionRepo> {
  /// The parameter `tools` of this provider.
  List<Tool> get tools;

  /// The parameter `instruction` of this provider.
  String? get instruction;
}

class _GeminiFunctionCallSessionProviderElement
    extends AutoDisposeProviderElement<ChatSessionRepo>
    with GeminiFunctionCallSessionRef {
  _GeminiFunctionCallSessionProviderElement(super.provider);

  @override
  List<Tool> get tools => (origin as GeminiFunctionCallSessionProvider).tools;
  @override
  String? get instruction =>
      (origin as GeminiFunctionCallSessionProvider).instruction;
}

String _$generativeAIModelHash() => r'b6901c489a10c15012a0b6e27c43ff5bc2417218';

/// See also [GenerativeAIModel].
@ProviderFor(GenerativeAIModel)
final generativeAIModelProvider =
    AutoDisposeNotifierProvider<GenerativeAIModel, GenerativeAIModels>.internal(
      GenerativeAIModel.new,
      name: r'generativeAIModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$generativeAIModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GenerativeAIModel = AutoDisposeNotifier<GenerativeAIModels>;
String _$isGeminiEchoMockHash() => r'd0cb08b68a1769faede4b926a0bf5536121b8ac2';

/// See also [IsGeminiEchoMock].
@ProviderFor(IsGeminiEchoMock)
final isGeminiEchoMockProvider =
    AutoDisposeNotifierProvider<IsGeminiEchoMock, bool>.internal(
      IsGeminiEchoMock.new,
      name: r'isGeminiEchoMockProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$isGeminiEchoMockHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$IsGeminiEchoMock = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
