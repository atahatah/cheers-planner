// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$participantRepoHash() => r'3ec0e3b2ddb435bfc1daeeeb48ee1adccd660864';

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

/// See also [participantRepo].
@ProviderFor(participantRepo)
const participantRepoProvider = ParticipantRepoFamily();

/// See also [participantRepo].
class ParticipantRepoFamily extends Family<ParticipantRepo> {
  /// See also [participantRepo].
  const ParticipantRepoFamily();

  /// See also [participantRepo].
  ParticipantRepoProvider call(String eventId) {
    return ParticipantRepoProvider(eventId);
  }

  @override
  ParticipantRepoProvider getProviderOverride(
    covariant ParticipantRepoProvider provider,
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
  String? get name => r'participantRepoProvider';
}

/// See also [participantRepo].
class ParticipantRepoProvider extends AutoDisposeProvider<ParticipantRepo> {
  /// See also [participantRepo].
  ParticipantRepoProvider(String eventId)
    : this._internal(
        (ref) => participantRepo(ref as ParticipantRepoRef, eventId),
        from: participantRepoProvider,
        name: r'participantRepoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$participantRepoHash,
        dependencies: ParticipantRepoFamily._dependencies,
        allTransitiveDependencies:
            ParticipantRepoFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  ParticipantRepoProvider._internal(
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
    ParticipantRepo Function(ParticipantRepoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParticipantRepoProvider._internal(
        (ref) => create(ref as ParticipantRepoRef),
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
  AutoDisposeProviderElement<ParticipantRepo> createElement() {
    return _ParticipantRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParticipantRepoProvider && other.eventId == eventId;
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
mixin ParticipantRepoRef on AutoDisposeProviderRef<ParticipantRepo> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ParticipantRepoProviderElement
    extends AutoDisposeProviderElement<ParticipantRepo>
    with ParticipantRepoRef {
  _ParticipantRepoProviderElement(super.provider);

  @override
  String get eventId => (origin as ParticipantRepoProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
