// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entry_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventEntriesRepoHash() => r'1888d2b291fe2103eb41df699dc2e9a534435566';

/// See also [eventEntriesRepo].
@ProviderFor(eventEntriesRepo)
final eventEntriesRepoProvider = AutoDisposeProvider<EventEntriesRepo>.internal(
  eventEntriesRepo,
  name: r'eventEntriesRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventEntriesRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventEntriesRepoRef = AutoDisposeProviderRef<EventEntriesRepo>;
String _$eventEntryRepoHash() => r'60464f0c3c21928c4e0f64d583a8d2a6482cc4be';

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

/// See also [eventEntryRepo].
@ProviderFor(eventEntryRepo)
const eventEntryRepoProvider = EventEntryRepoFamily();

/// See also [eventEntryRepo].
class EventEntryRepoFamily extends Family<EventEntryRepo> {
  /// See also [eventEntryRepo].
  const EventEntryRepoFamily();

  /// See also [eventEntryRepo].
  EventEntryRepoProvider call(String eventId) {
    return EventEntryRepoProvider(eventId);
  }

  @override
  EventEntryRepoProvider getProviderOverride(
    covariant EventEntryRepoProvider provider,
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
  String? get name => r'eventEntryRepoProvider';
}

/// See also [eventEntryRepo].
class EventEntryRepoProvider extends AutoDisposeProvider<EventEntryRepo> {
  /// See also [eventEntryRepo].
  EventEntryRepoProvider(String eventId)
    : this._internal(
        (ref) => eventEntryRepo(ref as EventEntryRepoRef, eventId),
        from: eventEntryRepoProvider,
        name: r'eventEntryRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventEntryRepoHash,
        dependencies: EventEntryRepoFamily._dependencies,
        allTransitiveDependencies:
            EventEntryRepoFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventEntryRepoProvider._internal(
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
    EventEntryRepo Function(EventEntryRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventEntryRepoProvider._internal(
        (ref) => create(ref as EventEntryRepoRef),
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
  AutoDisposeProviderElement<EventEntryRepo> createElement() {
    return _EventEntryRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventEntryRepoProvider && other.eventId == eventId;
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
mixin EventEntryRepoRef on AutoDisposeProviderRef<EventEntryRepo> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventEntryRepoProviderElement
    extends AutoDisposeProviderElement<EventEntryRepo>
    with EventEntryRepoRef {
  _EventEntryRepoProviderElement(super.provider);

  @override
  String get eventId => (origin as EventEntryRepoProvider).eventId;
}

String _$eventEntryHash() => r'b6d9a20f63079ae6bcf008b25a6c6565c685410f';

/// See also [eventEntry].
@ProviderFor(eventEntry)
const eventEntryProvider = EventEntryFamily();

/// See also [eventEntry].
class EventEntryFamily extends Family<AsyncValue<EventEntry>> {
  /// See also [eventEntry].
  const EventEntryFamily();

  /// See also [eventEntry].
  EventEntryProvider call(String eventId) {
    return EventEntryProvider(eventId);
  }

  @override
  EventEntryProvider getProviderOverride(
    covariant EventEntryProvider provider,
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
  String? get name => r'eventEntryProvider';
}

/// See also [eventEntry].
class EventEntryProvider extends AutoDisposeFutureProvider<EventEntry> {
  /// See also [eventEntry].
  EventEntryProvider(String eventId)
    : this._internal(
        (ref) => eventEntry(ref as EventEntryRef, eventId),
        from: eventEntryProvider,
        name: r'eventEntryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventEntryHash,
        dependencies: EventEntryFamily._dependencies,
        allTransitiveDependencies: EventEntryFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventEntryProvider._internal(
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
    FutureOr<EventEntry> Function(EventEntryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventEntryProvider._internal(
        (ref) => create(ref as EventEntryRef),
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
  AutoDisposeFutureProviderElement<EventEntry> createElement() {
    return _EventEntryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventEntryProvider && other.eventId == eventId;
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
mixin EventEntryRef on AutoDisposeFutureProviderRef<EventEntry> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventEntryProviderElement
    extends AutoDisposeFutureProviderElement<EventEntry>
    with EventEntryRef {
  _EventEntryProviderElement(super.provider);

  @override
  String get eventId => (origin as EventEntryProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
