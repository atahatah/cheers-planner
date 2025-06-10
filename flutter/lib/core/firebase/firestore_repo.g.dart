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

String _$planDocumentHash() => r'e7345b72c4cb620b6689efdcef7b57137d0a9e31';

/// See also [planDocument].
@ProviderFor(planDocument)
const planDocumentProvider = PlanDocumentFamily();

/// See also [planDocument].
class PlanDocumentFamily extends Family<DocumentReference<EventEntry>> {
  /// See also [planDocument].
  const PlanDocumentFamily();

  /// See also [planDocument].
  PlanDocumentProvider call(String planId) {
    return PlanDocumentProvider(planId);
  }

  @override
  PlanDocumentProvider getProviderOverride(
    covariant PlanDocumentProvider provider,
  ) {
    return call(provider.planId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'planDocumentProvider';
}

/// See also [planDocument].
class PlanDocumentProvider
    extends AutoDisposeProvider<DocumentReference<EventEntry>> {
  /// See also [planDocument].
  PlanDocumentProvider(String planId)
    : this._internal(
        (ref) => planDocument(ref as PlanDocumentRef, planId),
        from: planDocumentProvider,
        name: r'planDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$planDocumentHash,
        dependencies: PlanDocumentFamily._dependencies,
        allTransitiveDependencies:
            PlanDocumentFamily._allTransitiveDependencies,
        planId: planId,
      );

  PlanDocumentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.planId,
  }) : super.internal();

  final String planId;

  @override
  Override overrideWith(
    DocumentReference<EventEntry> Function(PlanDocumentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanDocumentProvider._internal(
        (ref) => create(ref as PlanDocumentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        planId: planId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DocumentReference<EventEntry>> createElement() {
    return _PlanDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanDocumentProvider && other.planId == planId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, planId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlanDocumentRef on AutoDisposeProviderRef<DocumentReference<EventEntry>> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _PlanDocumentProviderElement
    extends AutoDisposeProviderElement<DocumentReference<EventEntry>>
    with PlanDocumentRef {
  _PlanDocumentProviderElement(super.provider);

  @override
  String get planId => (origin as PlanDocumentProvider).planId;
}

String _$plansCollectionHash() => r'043d6c2494e4764107d4c7e39175c53ce51da926';

/// See also [plansCollection].
@ProviderFor(plansCollection)
final plansCollectionProvider =
    AutoDisposeProvider<CollectionReference<EventEntry>>.internal(
      plansCollection,
      name: r'plansCollectionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$plansCollectionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PlansCollectionRef =
    AutoDisposeProviderRef<CollectionReference<EventEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
