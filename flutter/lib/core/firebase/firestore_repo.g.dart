// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreHash() => r'0e25e335c5657f593fc1baf3d9fd026e70bca7fa';

/// See also [firestore].
@ProviderFor(firestore)
final firestoreProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  firestore,
  name: r'firestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$userDocumentHash() => r'ba72592014053815d6af92cabfb48965268c2304';

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

/// See also [userDocument].
@ProviderFor(userDocument)
const userDocumentProvider = UserDocumentFamily();

/// See also [userDocument].
class UserDocumentFamily extends Family<DocumentReference<UserEntry>> {
  /// See also [userDocument].
  const UserDocumentFamily();

  /// See also [userDocument].
  UserDocumentProvider call(String uid) {
    return UserDocumentProvider(uid);
  }

  @override
  UserDocumentProvider getProviderOverride(
    covariant UserDocumentProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDocumentProvider';
}

/// See also [userDocument].
class UserDocumentProvider
    extends AutoDisposeProvider<DocumentReference<UserEntry>> {
  /// See also [userDocument].
  UserDocumentProvider(String uid)
    : this._internal(
        (ref) => userDocument(ref as UserDocumentRef, uid),
        from: userDocumentProvider,
        name: r'userDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userDocumentHash,
        dependencies: UserDocumentFamily._dependencies,
        allTransitiveDependencies:
            UserDocumentFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserDocumentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    DocumentReference<UserEntry> Function(UserDocumentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDocumentProvider._internal(
        (ref) => create(ref as UserDocumentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DocumentReference<UserEntry>> createElement() {
    return _UserDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDocumentProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserDocumentRef on AutoDisposeProviderRef<DocumentReference<UserEntry>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<UserEntry>>
    with UserDocumentRef {
  _UserDocumentProviderElement(super.provider);

  @override
  String get uid => (origin as UserDocumentProvider).uid;
}

String _$eventDocumentHash() => r'a64f4da8d8045fd37372d745b54e0bc27f4eb85e';

/// See also [eventDocument].
@ProviderFor(eventDocument)
const eventDocumentProvider = EventDocumentFamily();

/// See also [eventDocument].
class EventDocumentFamily extends Family<DocumentReference<EventEntry>> {
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
    extends AutoDisposeProvider<DocumentReference<EventEntry>> {
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
    DocumentReference<EventEntry> Function(EventDocumentRef provider) create,
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
  AutoDisposeProviderElement<DocumentReference<EventEntry>> createElement() {
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
mixin EventDocumentRef
    on AutoDisposeProviderRef<DocumentReference<EventEntry>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<EventEntry>>
    with EventDocumentRef {
  _EventDocumentProviderElement(super.provider);

  @override
  String get eventId => (origin as EventDocumentProvider).eventId;
}

String _$eventsCollectionHash() => r'516fd0f0af0db5e62e7f3fd11aad6b599dc40a11';

/// See also [eventsCollection].
@ProviderFor(eventsCollection)
final eventsCollectionProvider =
    AutoDisposeProvider<CollectionReference<EventEntry>>.internal(
      eventsCollection,
      name: r'eventsCollectionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$eventsCollectionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventsCollectionRef =
    AutoDisposeProviderRef<CollectionReference<EventEntry>>;
String _$participantsCollectionHash() =>
    r'9e5c26c5d23b7fe9efde482f82ba9bc78e2790ed';

/// See also [participantsCollection].
@ProviderFor(participantsCollection)
const participantsCollectionProvider = ParticipantsCollectionFamily();

/// See also [participantsCollection].
class ParticipantsCollectionFamily
    extends Family<CollectionReference<EventParticipant>> {
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
    extends AutoDisposeProvider<CollectionReference<EventParticipant>> {
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
    CollectionReference<EventParticipant> Function(
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
  AutoDisposeProviderElement<CollectionReference<EventParticipant>>
  createElement() {
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
    on AutoDisposeProviderRef<CollectionReference<EventParticipant>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ParticipantsCollectionProviderElement
    extends AutoDisposeProviderElement<CollectionReference<EventParticipant>>
    with ParticipantsCollectionRef {
  _ParticipantsCollectionProviderElement(super.provider);

  @override
  String get eventId => (origin as ParticipantsCollectionProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
