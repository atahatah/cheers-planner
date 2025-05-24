// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entry_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userEntryRepoHash() => r'557fa751958886d0f71d054acea4539d6fea29ba';

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

/// See also [userEntryRepo].
@ProviderFor(userEntryRepo)
const userEntryRepoProvider = UserEntryRepoFamily();

/// See also [userEntryRepo].
class UserEntryRepoFamily extends Family<UserEntryRepo> {
  /// See also [userEntryRepo].
  const UserEntryRepoFamily();

  /// See also [userEntryRepo].
  UserEntryRepoProvider call(String uid) {
    return UserEntryRepoProvider(uid);
  }

  @override
  UserEntryRepoProvider getProviderOverride(
    covariant UserEntryRepoProvider provider,
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
  String? get name => r'userEntryRepoProvider';
}

/// See also [userEntryRepo].
class UserEntryRepoProvider extends AutoDisposeProvider<UserEntryRepo> {
  /// See also [userEntryRepo].
  UserEntryRepoProvider(String uid)
    : this._internal(
        (ref) => userEntryRepo(ref as UserEntryRepoRef, uid),
        from: userEntryRepoProvider,
        name: r'userEntryRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userEntryRepoHash,
        dependencies: UserEntryRepoFamily._dependencies,
        allTransitiveDependencies:
            UserEntryRepoFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserEntryRepoProvider._internal(
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
    UserEntryRepo Function(UserEntryRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserEntryRepoProvider._internal(
        (ref) => create(ref as UserEntryRepoRef),
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
  AutoDisposeProviderElement<UserEntryRepo> createElement() {
    return _UserEntryRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserEntryRepoProvider && other.uid == uid;
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
mixin UserEntryRepoRef on AutoDisposeProviderRef<UserEntryRepo> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserEntryRepoProviderElement
    extends AutoDisposeProviderElement<UserEntryRepo>
    with UserEntryRepoRef {
  _UserEntryRepoProviderElement(super.provider);

  @override
  String get uid => (origin as UserEntryRepoProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
