// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventDocumentHash() => r'44a2feb9871207c0061b7be093692d697bc15b9a';

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

/// See also [eventDocument].
@ProviderFor(eventDocument)
const eventDocumentProvider = EventDocumentFamily();

/// See also [eventDocument].
class EventDocumentFamily extends Family<DocumentReference<Event>> {
  /// See also [eventDocument].
  const EventDocumentFamily();

  /// See also [eventDocument].
  EventDocumentProvider call(String eventId) {
    return EventDocumentProvider(eventId);
  }

  @override
  EventDocumentProvider getProviderOverride(
    covariant EventDocumentProvider provider,
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
  String? get name => r'eventDocumentProvider';
}

/// See also [eventDocument].
class EventDocumentProvider
    extends AutoDisposeProvider<DocumentReference<Event>> {
  /// See also [eventDocument].
  EventDocumentProvider(String eventId)
    : this._internal(
        (ref) => eventDocument(ref as EventDocumentRef, eventId),
        from: eventDocumentProvider,
        name: r'eventDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventDocumentHash,
        dependencies: EventDocumentFamily._dependencies,
        allTransitiveDependencies:
            EventDocumentFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventDocumentProvider._internal(
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
    DocumentReference<Event> Function(EventDocumentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventDocumentProvider._internal(
        (ref) => create(ref as EventDocumentRef),
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
  AutoDisposeProviderElement<DocumentReference<Event>> createElement() {
    return _EventDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDocumentProvider && other.eventId == eventId;
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
mixin EventDocumentRef on AutoDisposeProviderRef<DocumentReference<Event>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Event>>
    with EventDocumentRef {
  _EventDocumentProviderElement(super.provider);

  @override
  String get eventId => (origin as EventDocumentProvider).eventId;
}

String _$participantsCollectionHash() =>
    r'50ad80690dc876511f6cd84c3ba026301dcbc5df';

/// See also [participantsCollection].
@ProviderFor(participantsCollection)
const participantsCollectionProvider = ParticipantsCollectionFamily();

/// See also [participantsCollection].
class ParticipantsCollectionFamily
    extends Family<CollectionReference<Participant>> {
  /// See also [participantsCollection].
  const ParticipantsCollectionFamily();

  /// See also [participantsCollection].
  ParticipantsCollectionProvider call(String eventId) {
    return ParticipantsCollectionProvider(eventId);
  }

  @override
  ParticipantsCollectionProvider getProviderOverride(
    covariant ParticipantsCollectionProvider provider,
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
  String? get name => r'participantsCollectionProvider';
}

/// See also [participantsCollection].
class ParticipantsCollectionProvider
    extends AutoDisposeProvider<CollectionReference<Participant>> {
  /// See also [participantsCollection].
  ParticipantsCollectionProvider(String eventId)
    : this._internal(
        (ref) =>
            participantsCollection(ref as ParticipantsCollectionRef, eventId),
        from: participantsCollectionProvider,
        name: r'participantsCollectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$participantsCollectionHash,
        dependencies: ParticipantsCollectionFamily._dependencies,
        allTransitiveDependencies:
            ParticipantsCollectionFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  ParticipantsCollectionProvider._internal(
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
    CollectionReference<Participant> Function(
      ParticipantsCollectionRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParticipantsCollectionProvider._internal(
        (ref) => create(ref as ParticipantsCollectionRef),
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
  AutoDisposeProviderElement<CollectionReference<Participant>> createElement() {
    return _ParticipantsCollectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParticipantsCollectionProvider && other.eventId == eventId;
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
mixin ParticipantsCollectionRef
    on AutoDisposeProviderRef<CollectionReference<Participant>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ParticipantsCollectionProviderElement
    extends AutoDisposeProviderElement<CollectionReference<Participant>>
    with ParticipantsCollectionRef {
  _ParticipantsCollectionProviderElement(super.provider);

  @override
  String get eventId => (origin as ParticipantsCollectionProvider).eventId;
}

String _$participantDocumentHash() =>
    r'484199a75dbcb53b413463508413aff9722dbb9c';

/// See also [participantDocument].
@ProviderFor(participantDocument)
const participantDocumentProvider = ParticipantDocumentFamily();

/// See also [participantDocument].
class ParticipantDocumentFamily extends Family<DocumentReference<Participant>> {
  /// See also [participantDocument].
  const ParticipantDocumentFamily();

  /// See also [participantDocument].
  ParticipantDocumentProvider call(String eventId, String participantId) {
    return ParticipantDocumentProvider(eventId, participantId);
  }

  @override
  ParticipantDocumentProvider getProviderOverride(
    covariant ParticipantDocumentProvider provider,
  ) {
    return call(provider.eventId, provider.participantId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'participantDocumentProvider';
}

/// See also [participantDocument].
class ParticipantDocumentProvider
    extends AutoDisposeProvider<DocumentReference<Participant>> {
  /// See also [participantDocument].
  ParticipantDocumentProvider(String eventId, String participantId)
    : this._internal(
        (ref) => participantDocument(
          ref as ParticipantDocumentRef,
          eventId,
          participantId,
        ),
        from: participantDocumentProvider,
        name: r'participantDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$participantDocumentHash,
        dependencies: ParticipantDocumentFamily._dependencies,
        allTransitiveDependencies:
            ParticipantDocumentFamily._allTransitiveDependencies,
        eventId: eventId,
        participantId: participantId,
      );

  ParticipantDocumentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
    required this.participantId,
  }) : super.internal();

  final String eventId;
  final String participantId;

  @override
  Override overrideWith(
    DocumentReference<Participant> Function(ParticipantDocumentRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParticipantDocumentProvider._internal(
        (ref) => create(ref as ParticipantDocumentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
        participantId: participantId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DocumentReference<Participant>> createElement() {
    return _ParticipantDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParticipantDocumentProvider &&
        other.eventId == eventId &&
        other.participantId == participantId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);
    hash = _SystemHash.combine(hash, participantId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ParticipantDocumentRef
    on AutoDisposeProviderRef<DocumentReference<Participant>> {
  /// The parameter `eventId` of this provider.
  String get eventId;

  /// The parameter `participantId` of this provider.
  String get participantId;
}

class _ParticipantDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Participant>>
    with ParticipantDocumentRef {
  _ParticipantDocumentProviderElement(super.provider);

  @override
  String get eventId => (origin as ParticipantDocumentProvider).eventId;
  @override
  String get participantId =>
      (origin as ParticipantDocumentProvider).participantId;
}

String _$eventResultDocumentHash() =>
    r'39b707e5e82a616e21037a3cbba2424deb663f8c';

/// See also [eventResultDocument].
@ProviderFor(eventResultDocument)
const eventResultDocumentProvider = EventResultDocumentFamily();

/// See also [eventResultDocument].
class EventResultDocumentFamily extends Family<DocumentReference<EventResult>> {
  /// See also [eventResultDocument].
  const EventResultDocumentFamily();

  /// See also [eventResultDocument].
  EventResultDocumentProvider call(String eventId) {
    return EventResultDocumentProvider(eventId);
  }

  @override
  EventResultDocumentProvider getProviderOverride(
    covariant EventResultDocumentProvider provider,
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
  String? get name => r'eventResultDocumentProvider';
}

/// See also [eventResultDocument].
class EventResultDocumentProvider
    extends AutoDisposeProvider<DocumentReference<EventResult>> {
  /// See also [eventResultDocument].
  EventResultDocumentProvider(String eventId)
    : this._internal(
        (ref) => eventResultDocument(ref as EventResultDocumentRef, eventId),
        from: eventResultDocumentProvider,
        name: r'eventResultDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventResultDocumentHash,
        dependencies: EventResultDocumentFamily._dependencies,
        allTransitiveDependencies:
            EventResultDocumentFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventResultDocumentProvider._internal(
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
    DocumentReference<EventResult> Function(EventResultDocumentRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventResultDocumentProvider._internal(
        (ref) => create(ref as EventResultDocumentRef),
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
  AutoDisposeProviderElement<DocumentReference<EventResult>> createElement() {
    return _EventResultDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventResultDocumentProvider && other.eventId == eventId;
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
mixin EventResultDocumentRef
    on AutoDisposeProviderRef<DocumentReference<EventResult>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventResultDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<EventResult>>
    with EventResultDocumentRef {
  _EventResultDocumentProviderElement(super.provider);

  @override
  String get eventId => (origin as EventResultDocumentProvider).eventId;
}

String _$eventRepositoryHash() => r'c91a19e27ee7e4727dd0a1df2ae80d535e13d892';

/// See also [eventRepository].
@ProviderFor(eventRepository)
final eventRepositoryProvider = AutoDisposeProvider<EventRepository>.internal(
  eventRepository,
  name: r'eventRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventRepositoryRef = AutoDisposeProviderRef<EventRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
