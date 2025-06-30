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
String _$geminiModelRepoHash() => r'4e93966f4c34cc1e8078eda121de71dbe5e6e40e';

/// See also [geminiModelRepo].
@ProviderFor(geminiModelRepo)
final geminiModelRepoProvider = AutoDisposeProvider<GeminiModelRepo>.internal(
  geminiModelRepo,
  name: r'geminiModelRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiModelRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GeminiModelRepoRef = AutoDisposeProviderRef<GeminiModelRepo>;
String _$geminiChatSessionHash() => r'648bba245e117797f50d913cd40ad3edc29983f4';

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
    r'0f7b8fb8b17868af104dbae0ffa4b56ac4ded22a';

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

/// See also [geminiFunctionCallSession].
@ProviderFor(geminiFunctionCallSession)
const geminiFunctionCallSessionProvider = GeminiFunctionCallSessionFamily();

/// See also [geminiFunctionCallSession].
class GeminiFunctionCallSessionFamily extends Family<ChatSessionRepo> {
  /// See also [geminiFunctionCallSession].
  const GeminiFunctionCallSessionFamily();

  /// See also [geminiFunctionCallSession].
  GeminiFunctionCallSessionProvider call(List<Tool> tools) {
    return GeminiFunctionCallSessionProvider(tools);
  }

  @override
  GeminiFunctionCallSessionProvider getProviderOverride(
    covariant GeminiFunctionCallSessionProvider provider,
  ) {
    return call(provider.tools);
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
  GeminiFunctionCallSessionProvider(List<Tool> tools)
    : this._internal(
        (ref) => geminiFunctionCallSession(
          ref as GeminiFunctionCallSessionRef,
          tools,
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
      );

  GeminiFunctionCallSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tools,
  }) : super.internal();

  final List<Tool> tools;

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
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ChatSessionRepo> createElement() {
    return _GeminiFunctionCallSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeminiFunctionCallSessionProvider && other.tools == tools;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tools.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeminiFunctionCallSessionRef on AutoDisposeProviderRef<ChatSessionRepo> {
  /// The parameter `tools` of this provider.
  List<Tool> get tools;
}

class _GeminiFunctionCallSessionProviderElement
    extends AutoDisposeProviderElement<ChatSessionRepo>
    with GeminiFunctionCallSessionRef {
  _GeminiFunctionCallSessionProviderElement(super.provider);

  @override
  List<Tool> get tools => (origin as GeminiFunctionCallSessionProvider).tools;
}

String _$generativeAIModelHash() => r'43fea863f6be09441a7d725f30411e7f52517fa3';

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
