// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entry_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventEntryRepoHash() => r'0c959d4969ef649578b5ecd0a6d195b7ff6bee06';

/// See also [eventEntryRepo].
@ProviderFor(eventEntryRepo)
final eventEntryRepoProvider = AutoDisposeProvider<EventEntryRepo>.internal(
  eventEntryRepo,
  name: r'eventEntryRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventEntryRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventEntryRepoRef = AutoDisposeProviderRef<EventEntryRepo>;
String _$candidateDateTimeRepoHash() =>
    r'ae4b1672b313bcb9c76750cee9d0a43b54e440b5';

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

/// See also [candidateDateTimeRepo].
@ProviderFor(candidateDateTimeRepo)
const candidateDateTimeRepoProvider = CandidateDateTimeRepoFamily();

/// See also [candidateDateTimeRepo].
class CandidateDateTimeRepoFamily extends Family<CandidateDateTimeRepo> {
  /// See also [candidateDateTimeRepo].
  const CandidateDateTimeRepoFamily();

  /// See also [candidateDateTimeRepo].
  CandidateDateTimeRepoProvider call(String eventId) {
    return CandidateDateTimeRepoProvider(eventId);
  }

  @override
  CandidateDateTimeRepoProvider getProviderOverride(
    covariant CandidateDateTimeRepoProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'candidateDateTimeRepoProvider';
}

/// See also [candidateDateTimeRepo].
class CandidateDateTimeRepoProvider
    extends AutoDisposeProvider<CandidateDateTimeRepo> {
  /// See also [candidateDateTimeRepo].
  CandidateDateTimeRepoProvider(String eventId)
    : this._internal(
        (ref) =>
            candidateDateTimeRepo(ref as CandidateDateTimeRepoRef, eventId),
        from: candidateDateTimeRepoProvider,
        name: r'candidateDateTimeRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$candidateDateTimeRepoHash,
        dependencies: CandidateDateTimeRepoFamily._dependencies,
        allTransitiveDependencies:
            CandidateDateTimeRepoFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  CandidateDateTimeRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    CandidateDateTimeRepo Function(CandidateDateTimeRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CandidateDateTimeRepoProvider._internal(
        (ref) => create(ref as CandidateDateTimeRepoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CandidateDateTimeRepo> createElement() {
    return _CandidateDateTimeRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CandidateDateTimeRepoProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CandidateDateTimeRepoRef
    on AutoDisposeProviderRef<CandidateDateTimeRepo> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CandidateDateTimeRepoProviderElement
    extends AutoDisposeProviderElement<CandidateDateTimeRepo>
    with CandidateDateTimeRepoRef {
  _CandidateDateTimeRepoProviderElement(super.provider);

  @override
  String get eventId => (origin as CandidateDateTimeRepoProvider).eventId;
}

String _$candidateAreaRepoHash() => r'b0ca455bf1fcb45c15b78fc9ffe35ea62d03d1f8';

/// See also [candidateAreaRepo].
@ProviderFor(candidateAreaRepo)
const candidateAreaRepoProvider = CandidateAreaRepoFamily();

/// See also [candidateAreaRepo].
class CandidateAreaRepoFamily extends Family<CandidateAreaRepo> {
  /// See also [candidateAreaRepo].
  const CandidateAreaRepoFamily();

  /// See also [candidateAreaRepo].
  CandidateAreaRepoProvider call(String eventId) {
    return CandidateAreaRepoProvider(eventId);
  }

  @override
  CandidateAreaRepoProvider getProviderOverride(
    covariant CandidateAreaRepoProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'candidateAreaRepoProvider';
}

/// See also [candidateAreaRepo].
class CandidateAreaRepoProvider extends AutoDisposeProvider<CandidateAreaRepo> {
  /// See also [candidateAreaRepo].
  CandidateAreaRepoProvider(String eventId)
    : this._internal(
        (ref) => candidateAreaRepo(ref as CandidateAreaRepoRef, eventId),
        from: candidateAreaRepoProvider,
        name: r'candidateAreaRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$candidateAreaRepoHash,
        dependencies: CandidateAreaRepoFamily._dependencies,
        allTransitiveDependencies:
            CandidateAreaRepoFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  CandidateAreaRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    CandidateAreaRepo Function(CandidateAreaRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CandidateAreaRepoProvider._internal(
        (ref) => create(ref as CandidateAreaRepoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CandidateAreaRepo> createElement() {
    return _CandidateAreaRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CandidateAreaRepoProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CandidateAreaRepoRef on AutoDisposeProviderRef<CandidateAreaRepo> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CandidateAreaRepoProviderElement
    extends AutoDisposeProviderElement<CandidateAreaRepo>
    with CandidateAreaRepoRef {
  _CandidateAreaRepoProviderElement(super.provider);

  @override
  String get eventId => (origin as CandidateAreaRepoProvider).eventId;
}

String _$eventResultRepoHash() => r'36267a72a261fcb55b89427bbfc3d3ade1ff19f0';

/// See also [eventResultRepo].
@ProviderFor(eventResultRepo)
const eventResultRepoProvider = EventResultRepoFamily();

/// See also [eventResultRepo].
class EventResultRepoFamily extends Family<EventResultRepo> {
  /// See also [eventResultRepo].
  const EventResultRepoFamily();

  /// See also [eventResultRepo].
  EventResultRepoProvider call(String eventId) {
    return EventResultRepoProvider(eventId);
  }

  @override
  EventResultRepoProvider getProviderOverride(
    covariant EventResultRepoProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventResultRepoProvider';
}

/// See also [eventResultRepo].
class EventResultRepoProvider extends AutoDisposeProvider<EventResultRepo> {
  /// See also [eventResultRepo].
  EventResultRepoProvider(String eventId)
    : this._internal(
        (ref) => eventResultRepo(ref as EventResultRepoRef, eventId),
        from: eventResultRepoProvider,
        name: r'eventResultRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventResultRepoHash,
        dependencies: EventResultRepoFamily._dependencies,
        allTransitiveDependencies:
            EventResultRepoFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventResultRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    EventResultRepo Function(EventResultRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventResultRepoProvider._internal(
        (ref) => create(ref as EventResultRepoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<EventResultRepo> createElement() {
    return _EventResultRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventResultRepoProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventResultRepoRef on AutoDisposeProviderRef<EventResultRepo> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventResultRepoProviderElement
    extends AutoDisposeProviderElement<EventResultRepo>
    with EventResultRepoRef {
  _EventResultRepoProviderElement(super.provider);

  @override
  String get eventId => (origin as EventResultRepoProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
